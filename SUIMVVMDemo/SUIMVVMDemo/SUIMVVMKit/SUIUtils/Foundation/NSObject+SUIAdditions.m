//
//  NSObject+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSObject+SUIAdditions.h"

@implementation NSObject (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  AssociatedObject
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - AssociatedObject

- (id)sui_getAssociatedObjectWithKey:(const void *)cKey
{
    return objc_getAssociatedObject(self, cKey);
}

- (void)sui_setAssociatedAssignObject:(id)cValue key:(const void *)cKey
{
    objc_setAssociatedObject(self, cKey, cValue, OBJC_ASSOCIATION_ASSIGN);
}

- (void)sui_setAssociatedRetainObject:(id)cValue key:(const void *)cKey
{
    objc_setAssociatedObject(self, cKey, cValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sui_setAssociatedCopyObject:(id)cValue key:(const void *)cKey
{
    objc_setAssociatedObject(self, cKey, cValue, OBJC_ASSOCIATION_COPY);
}

- (void)sui_setAssociatedObject:(id)cValue key:(const void *)cKey policy:(objc_AssociationPolicy)cPolicy
{
    objc_setAssociatedObject(self, cKey, cValue, cPolicy);
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  PerformedOnce
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - PerformedOnce

- (void)sui_performOnce:(void (^)(void))cb key:(NSString *)cKey
{
    NSMutableArray *performedArray = [self sui_performedArray];
    if (![performedArray containsObject:cKey])
    {
        [performedArray addObject:cKey];
        cb();
    }
}

- (NSMutableArray *)sui_performedArray
{
    NSMutableArray *curArray = [self sui_getAssociatedObjectWithKey:_cmd];
    if (curArray) return curArray;
    
    curArray = [NSMutableArray array];
    [self sui_setAssociatedObject:curArray key:_cmd policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
    return curArray;
}


@end
