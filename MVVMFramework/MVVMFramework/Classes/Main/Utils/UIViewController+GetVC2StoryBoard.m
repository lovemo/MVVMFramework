//
//  UIViewController+GetVC2StoryBoard.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "UIViewController+GetVC2StoryBoard.h"

@implementation UIViewController (GetVC2StoryBoard)
+ (id)viewControllerWithStoryBoardName:(NSString *)storyboardName identifier:(NSString *)identifier {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}
@end
