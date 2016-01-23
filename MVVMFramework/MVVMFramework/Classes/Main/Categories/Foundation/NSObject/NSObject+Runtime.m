//
//  NSObject+Runtime.m
//  SUICategoriesDemo
//
//  Created by zzZ on 15/12/8.
//  Copyright © 2015年 suio~. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

#pragma mark - AssociatedObject

- (void)sui_setAssociatedObject:(nullable id)cValue key:(const void *)cKey policy:(objc_AssociationPolicy)cPolicy
{
    objc_setAssociatedObject(self, cKey, cValue, cPolicy);
}

- (nullable id)sui_getAssociatedObjectWithKey:(const void *)cKey
{
    return objc_getAssociatedObject(self, cKey);
}

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
