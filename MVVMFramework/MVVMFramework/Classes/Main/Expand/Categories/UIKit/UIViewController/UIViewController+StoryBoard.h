//
//  UIViewController+StoryBoard.h
//  MVVMFramework
//
//  Created by yuantao on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (StoryBoard)
/**
 *  返回storybosrd中指定identifer的控制器
 *
 *  @param storyboardName 控制器所在的storyboard
 *  @param identifier     控制器在storyboard中指定的标识符
 *
 *  @return 指定identifer的控制器
 */
+ (id)viewControllerWithStoryBoardName:(NSString *)storyboardName identifier:(NSString *)identifier;

@end
