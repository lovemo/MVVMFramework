//
//  NSObject+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  AssociatedObject
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - AssociatedObject

- (nullable id)sui_getAssociatedObjectWithKey:(const void *)cKey;

- (void)sui_setAssociatedAssignObject:(nullable id)cValue key:(const void *)cKey;

- (void)sui_setAssociatedRetainObject:(nullable id)cValue key:(const void *)cKey;

- (void)sui_setAssociatedCopyObject:(nullable id)cValue key:(const void *)cKey;

- (void)sui_setAssociatedObject:(nullable id)cValue key:(const void *)cKey policy:(objc_AssociationPolicy)cPolicy;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  PerformedOnce
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - PerformedOnce

- (void)sui_performOnce:(void (^)(void))cb key:(NSString *)cKey;


@end

NS_ASSUME_NONNULL_END
