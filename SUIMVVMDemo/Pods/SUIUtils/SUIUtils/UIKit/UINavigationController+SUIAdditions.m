//
//  UINavigationController+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UINavigationController+SUIAdditions.h"
#import "SUIMacro.h"
#import "NSArray+SUIAdditions.h"
#import "NSObject+SUIAdditions.h"

@implementation UINavigationController (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Relationship
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Relationship

- (UIViewController *)sui_rootVC
{
    if (self.viewControllers.count > 0) {
        UIViewController *curVC = [self.viewControllers firstObject];
        return curVC;
    }
    return nil;
}

- (BOOL)sui_onlyHasRootVC
{
    if (self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

- (UIViewController *)sui_findVC:(NSString *)className
{
    __block UIViewController *curVC = nil;
    [self.viewControllers sui_eachWithStop:^BOOL(__kindof UIViewController * _Nonnull obj, NSUInteger index) {
        if ([obj isKindOfClass:NSClassFromString(className)]) {
            curVC = obj;
            return YES;
        }
        return NO;
    }];
    return curVC;
}

- (UIViewController *)sui_findReverseVC:(NSString *)className
{
    __block UIViewController *curVC = nil;
    [self.viewControllers sui_eachReverseWithStop:^BOOL(__kindof UIViewController * _Nonnull obj, NSUInteger index) {
        if ([obj isKindOfClass:NSClassFromString(className)]) {
            curVC = obj;
            return YES;
        }
        return NO;
    }];
    return curVC;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  StoryboardLink
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - StoryboardLink

- (NSString *)sui_storyboardNameAndID
{
    return [self sui_getAssociatedObjectWithKey:@selector(sui_storyboardNameAndID)];
}
- (void)setSui_storyboardNameAndID:(NSString *)sui_storyboardNameAndID
{
    [self sui_setAssociatedCopyObject:sui_storyboardNameAndID key:@selector(sui_storyboardNameAndID)];
    [self sui_setRootViewController];
}

- (void)sui_setRootViewController
{
    NSArray *components = [self.sui_storyboardNameAndID componentsSeparatedByString:@"."];
    NSString *curStoryboardName = nil;
    NSString *curStoryboardID = nil;
    if (components.count > 0) {
        curStoryboardName = components[0];
        if (components.count > 1) {
            curStoryboardID = components[1];
        }
    }
    
    if (curStoryboardName) {
        UIViewController *curRootVC = nil;
        if (curStoryboardID) {
            curRootVC = gStoryboardInstantiate(curStoryboardName, curStoryboardID);
        } else {
            curRootVC = gStoryboardInitialViewController(curStoryboardName);
        }
        SUIAssert(curRootVC, @"check storyboardNameAndID");
        [self setViewControllers:@[curRootVC] animated:NO];
    }
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Pop
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Pop

- (NSArray<UIViewController *> *)sui_popToVC:(NSString *)className animated:(BOOL)animated
{
    UIViewController *curVC = [self sui_findReverseVC:className];
    NSArray *curAry = [self popToViewController:curVC animated:animated];
    return curAry;
}

- (NSArray<UIViewController *> *)sui_popToIndex:(NSUInteger)cIndex animated:(BOOL)animated
{
    NSUInteger curCount = self.viewControllers.count;
    if (cIndex < curCount-1) {
        UIViewController *curVC = self.viewControllers[cIndex];
        NSArray *curAry = [self popToViewController:curVC animated:animated];
        return curAry;
    }
    return self.viewControllers;
}


@end
