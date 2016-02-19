//
//  NSObject+Runtime.h
//  SUICategoriesDemo
//
//  Created by zzZ on 15/12/8.
//  Copyright © 2015年 suio~. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)


#pragma mark - AssociatedObject

- (void)sui_setAssociatedObject:(nullable id)cValue key:(const void *)cKey policy:(objc_AssociationPolicy)cPolicy;

- (nullable id)sui_getAssociatedObjectWithKey:(const void *)cKey;

#pragma mark - PerformedOnce

- (void)sui_performOnce:(void (^)(void))cb key:(NSString *)cKey;

@end

NS_ASSUME_NONNULL_END
