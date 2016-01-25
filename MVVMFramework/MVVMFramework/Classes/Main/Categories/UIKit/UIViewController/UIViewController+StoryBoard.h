//
//  UIViewController+StoryBoard.h
//  MVVMFramework
//
//  Created by yuantao on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (StoryBoard)

+ (id)viewControllerWithStoryBoardName:(NSString *)storyboardName identifier:(NSString *)identifier;

@end
