//
//  UIViewController+SVVAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/19.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIViewController+SVVAdditions.h"
#import "SUIMacro.h"
#import "NSObject+SUIAdditions.h"

@implementation UIViewController (SVVAdditions)


- (NSString *)svv_identifier
{
    NSString *curIdentifier = [self sui_getAssociatedObjectWithKey:@selector(svv_identifier)];
    if (curIdentifier) return curIdentifier;
    
    NSString *curClassName = NSStringFromClass([self class]);
    curIdentifier = curClassName;
    
    self.svv_identifier = curIdentifier;
    return curIdentifier;
}
- (void)setSvv_identifier:(NSString *)svv_identifier
{
    [self sui_setAssociatedCopyObject:svv_identifier key:@selector(svv_identifier)];
}


+ (UIViewController *)svv_viewControllerWithStoryBoardName:(NSString *)storyboardName identifier:(NSString *)identifier
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}


@end
