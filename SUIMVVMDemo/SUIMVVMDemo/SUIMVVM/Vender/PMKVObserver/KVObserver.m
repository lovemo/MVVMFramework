//
//  PMKVObserver.m
//  PMKVObserver
//
//  Created by Kevin Ballard on 11/18/15.
//  Copyright © 2015 Postmates. All rights reserved.
//
//  Licensed under the MIT license <LICENSE or
//  http://opensource.org/licenses/MIT>. This file may not be copied, modified,
//  or distributed except according to those terms.
//

#import "KVObserver.h"
#import <stdatomic.h>
#import <objc/runtime.h>
#import <pthread.h>

NS_ASSUME_NONNULL_BEGIN

static void *kContext = &kContext;

@interface PMKVObserverDeallocSpy: NSObject
- (instancetype)initWithObserver:(PMKVObserver *)observer shouldBlock:(BOOL)flag NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end

typedef NS_ENUM(uint_fast8_t, PMKVObserverState) {
    /// KVO has finished being setup and can now be cancelled
    PMKVObserverStateSetup = 1 << 0,
    /// -cancel has not yet been invoked
    PMKVObserverStateActive = 1 << 1,
    PMKVObserverStateCancellable = (PMKVObserverStateSetup | PMKVObserverStateActive),
    
    /// KVO has been successfully deregistered
    /// This lets us skip the semaphore for subsequent cancels
    PMKVObserverStateDeregistered = 1 << 2
};

typedef void (^Callback)(id object, NSDictionary<NSString *,id> * _Nullable change, PMKVObserver *kvo);
typedef void (^ObserverCallback)(id observer, id object, NSDictionary<NSString *,id> * _Nullable change, PMKVObserver *kvo);

@implementation PMKVObserver {
    __weak id _Nullable _object;
    // if we cancel because the object started dealloc, our __weak ivar will be nil already, so we need a non-weak version
    // NB: _unsafeObject is ONLY accessed after init in -teardown and it's protected by the semaphore
    __unsafe_unretained id _Nullable _unsafeObject;
    __weak id _Nullable _observer;
    NSString *_keyPath;
    atomic_uint_fast8_t _state;
    BOOL _hasObserver;
    
    // use an activity count for _callback. We need to nil it out once cancelled, but since it's reference-counted we
    // can't just use an atomic pointer. We can't use a spinlock either because that's unsafe on iOS, so instead we
    // keep our own reference count of when it's being used (either by the callback or -teardown) and nil it out once
    // the count hits zero. 16 bits ought to be enough.
    atomic_uint_fast16_t _activityCount;
    id _Nullable _callback;
    
    // we need to be able to block in -teardown until KVO is deregistered (both to preserve the guarantee of -cancel
    // and to ensure the KVO is deregistered before the object deallocates). Can't use a spinlock because it's unsafe
    // on iOS, so we settle for a mutex.
    pthread_mutex_t _mutex;
}

+ (instancetype)observeObject:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(Callback)block {
    return [[self alloc] initWithObject:object keyPath:keyPath options:options block:block];
}

+ (instancetype)observeObject:(id)object observer:(id)observer keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(ObserverCallback)block {
    return [[self alloc] initWithObserver:observer object:object keyPath:keyPath options:options block:block];
}

- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(Callback)block {
    if ((self = [super init])) {
        setup(self, nil, object, keyPath, options, (id)[block copy]);
    }
    return self;
}

- (instancetype)initWithObserver:(id)observer object:(id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(ObserverCallback)block {
    if ((self = [super init])) {
        setup(self, observer, object, keyPath, options, (id)[block copy]);
    }
    return self;
}

static void setup(PMKVObserver *self, id _Nullable NS_VALID_UNTIL_END_OF_SCOPE observer, id NS_VALID_UNTIL_END_OF_SCOPE object, NSString *keyPath, NSKeyValueObservingOptions options, id callback) {
    // NS_VALID_UNTIL_END_OF_SCOPE ensures the object/observer stay alive until we've finished the observation process
    // We can't have either one of them dealloc before we finish with -addObserver:forKeyPath:options:context: because
    // we can't unregister KVO until that method finishes, and we can't let the object dealloc before KVO is unregistered.
    
    self->_observer = observer;
    self->_hasObserver = observer != nil;
    
    self->_object = object;
    self->_unsafeObject = object;
    self->_keyPath = [keyPath copy];
    atomic_init(&self->_activityCount, 1);
    self->_callback = callback;
    int retval;
    while ((retval = pthread_mutex_init(&self->_mutex, NULL))) {
        NSCAssert(retval == EAGAIN, @"pthread_mutex_init: %s", strerror(retval));
    }
    atomic_init(&self->_state, PMKVObserverStateActive);
    [self installDeallocSpiesForObject:object observer:observer];
    [object addObserver:self forKeyPath:self->_keyPath options:options context:kContext];
    if ((atomic_fetch_or_explicit(&self->_state, PMKVObserverStateSetup, memory_order_release) & PMKVObserverStateActive) == 0) {
        // we cancelled during init, shut it down
        [self teardown];
    }
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"-[PMKVObserver init] is not available" userInfo:nil];
}

- (void)dealloc {
    int retval = pthread_mutex_destroy(&_mutex);
    if (__builtin_expect(retval, 0) != 0) {
        NSLog(@"PMKVObserver: pthread_mutex_destroy: %s", strerror(retval));
    }
}

- (void)cancel {
    [self cancel:NO];
}

- (void)cancel:(BOOL)shouldBlock {
    // When read load the state, if it says it's Cancellable, this means we can see the Setup flag from init.
    // But we need a synchronizes-with edge to guarantee we can also see the KVO state.
    // We only need that edge if it's been Setup (and not Deregistered), so defer the fence until then.
    uint_fast8_t oldState = atomic_fetch_and_explicit(&_state, ~PMKVObserverStateActive, memory_order_relaxed);
    if ((oldState & PMKVObserverStateDeregistered) != 0) {
        // if we've already deregistered the KVO there's no reason to block
        return;
    }
    // If we're cancelling in response to the object deallocating, we MUST block. Otherwise, we don't have to block because the
    // _state flag ensures the callback cannot be invoked again even though we haven't actually unregistered yet.
    if (shouldBlock || (oldState & PMKVObserverStateCancellable) == PMKVObserverStateCancellable) {
        atomic_thread_fence(memory_order_acquire);
        [self teardown];
    }
}

- (void)teardown {
    int retval = pthread_mutex_lock(&_mutex);
    NSAssert(__builtin_expect(retval, 0) == 0, @"pthread_mutex_lock: %s", strerror(retval));
    @try {
        if (_unsafeObject == nil) {
            // we must have already cleared it in a concurrent teardown
            return;
        }
        [_unsafeObject removeObserver:self forKeyPath:_keyPath context:kContext];
        _unsafeObject = nil;
    }
    @finally {
        retval = pthread_mutex_unlock(&_mutex);
        NSAssert(__builtin_expect(retval, 0) == 0, @"pthread_mutex_unlock: %s", strerror(retval));
    }
    atomic_fetch_or_explicit(&_state, PMKVObserverStateDeregistered, memory_order_relaxed);
    // only one caller can ever make it to this point
    // "release" our callback. A simple decrement suffices.
    if (atomic_fetch_sub_explicit(&_activityCount, 1, memory_order_relaxed) == 1) {
        _callback = nil;
    }
    [self clearDeallocSpies];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString *,id> *)change context:(nullable void *)context {
    if (context != kContext) {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    if (keyPath == nil || object == nil) {
        // I don't know how this is even possible, but the declaration has them as nullable. Bail out if this happens.
        return;
    }
    if ((atomic_load_explicit(&_state, memory_order_relaxed) & PMKVObserverStateActive) == 0) {
        // we must have cancelled on another thread at the same time. Skip the callback.
        return;
    }
    // We need to "retain" our callback, unless it's already at zero.
    uint_fast16_t count = atomic_load_explicit(&_activityCount, memory_order_relaxed);
    do {
        if (count == 0) {
            // callback was fully released and should be treated as nil
            return;
        }
        NSAssert(__builtin_expect(count != UINT_FAST8_MAX, 0), @"callback activity count hit UINT_FAST8_MAX");
    } while (!atomic_compare_exchange_weak_explicit(&_activityCount, &count, count+1, memory_order_relaxed, memory_order_relaxed));
    // we've now "retained" it and it's safe to access
    id callback = _callback;
    // now "release" it
    if (atomic_fetch_sub_explicit(&_activityCount, 1, memory_order_relaxed) == 1) {
        _callback = nil;
        // we were cancelled during the preceding code
        return;
    }
    if (_hasObserver) {
        id observer = _observer;
        if (!observer) {
            // our observer is deallocating. Skip the callback.
            return;
        }
        ((ObserverCallback)callback)(observer, object, change, self);
    } else {
        ((Callback)callback)(object, change, self);
    }
}

- (void)installDeallocSpiesForObject:(id)object observer:(nullable id)observer {
    PMKVObserverDeallocSpy *objectSpy = [[PMKVObserverDeallocSpy alloc] initWithObserver:self shouldBlock:YES];
    void * const key = [self deallocSpyAssociatedObjectKey];
    objc_setAssociatedObject(object, key, objectSpy, OBJC_ASSOCIATION_RETAIN);
    if (observer && observer != object) {
        objectSpy = [[PMKVObserverDeallocSpy alloc] initWithObserver:self shouldBlock:NO];
        objc_setAssociatedObject(observer, key, objectSpy, OBJC_ASSOCIATION_RETAIN);
    }
}

- (void)clearDeallocSpies {
    id object = _object;
    void * const key = [self deallocSpyAssociatedObjectKey];
    if (object) {
        objc_setAssociatedObject(object, key, nil, OBJC_ASSOCIATION_RETAIN);
    }
    id observer = _observer;
    if (observer) {
        objc_setAssociatedObject(observer, key, nil, OBJC_ASSOCIATION_RETAIN);
    }
}

- (void *)deallocSpyAssociatedObjectKey {
    // We could return `self`, but that runs the risk of client code also trying to use us as a key
    // (though that's rather unlikely).
    // So instead lets return a pointer to one of our ivars. Doesn't really matter which one, so
    // we'll go with the first one.
    return &_object;
}
@end

@implementation PMKVObserverDeallocSpy {
    PMKVObserver * _Nonnull _observer;
    BOOL _shouldBlock;
}
- (instancetype)initWithObserver:(PMKVObserver *)observer shouldBlock:(BOOL)flag {
    if ((self = [super init])) {
        _observer = observer;
        _shouldBlock = flag;
    }
    return self;
}

- (void)dealloc {
    [_observer cancel:_shouldBlock];
}
@end

NS_ASSUME_NONNULL_END
