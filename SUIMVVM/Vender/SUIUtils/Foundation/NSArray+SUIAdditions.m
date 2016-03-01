//
//  NSArray+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSArray+SUIAdditions.h"
#import "SUIMacro.h"

@implementation NSArray (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Prehash
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Prehash

- (NSString *)sui_toString
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *anyError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&anyError];
        if (anyError) {
            SUILogError(@"array to string Error ⤭ %@ ⤪", anyError);
            return nil;
        }
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    } else {
        SUILogError(@"array to string invalid Array ⤭ %@ ⤪", self);
    }
    return nil;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Operate
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Operate

- (void)sui_each:(void (^)(id _Nonnull, NSUInteger))cb
{
    if (self.count == 0) return;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        cb(obj, idx);
    }];
}

- (void)sui_eachReverse:(void (^)(id _Nonnull, NSUInteger))cb
{
    if (self.count == 0) return;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        cb(obj, idx);
    }];
}

- (void)sui_eachWithStop:(BOOL (^)(id _Nonnull, NSUInteger))cb
{
    if (self.count == 0) return;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL toStop = cb(obj, idx);
        if (toStop) {
            *stop = YES;
        }
    }];
}

- (void)sui_eachReverseWithStop:(BOOL (^)(id _Nonnull, NSUInteger))cb
{
    if (self.count == 0) return;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL toStop = cb(obj, idx);
        if (toStop) {
            *stop = YES;
        }
    }];
}

- (instancetype)sui_map:(id  _Nonnull (^)(id _Nonnull, NSUInteger))cb
{
    if (self.count == 0) return @[];
    NSMutableArray *curAry = [NSMutableArray arrayWithCapacity:self.count];
    [self sui_each:^(id  _Nonnull obj, NSUInteger index) {
        id returnValue = cb(obj, index);
        if (!kNilOrNull(returnValue)) {
            [curAry addObject:returnValue];
        }
    }];
    return curAry;
}

- (instancetype)sui_filter:(BOOL (^)(id _Nonnull))cb
{
    if (self.count == 0) return @[];
    NSPredicate *curPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return cb(evaluatedObject);
    }];
    NSArray *curAry = [self filteredArrayUsingPredicate:curPredicate];
    return curAry;
}

- (instancetype)sui_filterInArray:(NSArray *)array
{
    if (self.count == 0) return @[];
    NSPredicate *curPredicate = gPredicate(@"SELF in %@", array);
    NSArray *curAry = [self filteredArrayUsingPredicate:curPredicate];
    return curAry;
}

// @[@(1), @(2), @(4)] -- @[@(1), @(3)] --> @[@(2), @(4)]
- (instancetype)sui_filterNotInArray:(NSArray *)array
{
    if (self.count == 0) return @[];
    NSPredicate *curPredicate = gPredicate(@"NOT (SELF in %@)", array);
    NSArray *curAry = [self filteredArrayUsingPredicate:curPredicate];
    return curAry;
}

- (instancetype)sui_merge:(NSArray *)array
{
    NSMutableArray *curAry = [NSMutableArray arrayWithArray:self];
    [curAry addObjectsFromArray:array];
    return curAry;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Sequence
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Sequence


- (id)sui_randomObject
{
    if (self.count == 0) return nil;
    NSInteger curIdx = gRandomInRange(0, self.count-1);
    id curObj = self[curIdx];
    return curObj;
}

- (instancetype)sui_shuffledArray
{
    if (self.count == 0) return @[];
    NSMutableArray *curAry = [self mutableCopy];
    for (NSInteger idx = self.count - 1; idx > 0; idx--) {
        [curAry exchangeObjectAtIndex:arc4random_uniform((u_int32_t)idx + 1) withObjectAtIndex:idx];
    }
    return curAry;
}

- (instancetype)sui_reverseObject
{
    if (self.count == 0) return @[];
    NSEnumerator *curEnumer = [self reverseObjectEnumerator];
    NSArray *curAry = [[NSMutableArray alloc] initWithArray:[curEnumer allObjects]];
    return curAry;
}


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NSMutableArray
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@implementation NSMutableArray (SUIAdditions)


- (void)sui_moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (toIndex != fromIndex && fromIndex < [self count] && toIndex< [self count]) {
        id obj = [self objectAtIndex:fromIndex];
        [self removeObjectAtIndex:fromIndex];
        if (toIndex >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:toIndex];
        }
    }
}


@end
