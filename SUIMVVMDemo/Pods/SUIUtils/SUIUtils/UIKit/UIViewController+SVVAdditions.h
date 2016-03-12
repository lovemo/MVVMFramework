//
//  UIViewController+SVVAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/19.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SVVAdditions)


@property (null_resettable,nonatomic,copy) NSString *svv_identifier;


/**
 *  返回storybosrd中指定identifer的控制器
 *
 *  @param storyboardName 控制器所在的storyboard
 *  @param identifier     控制器在storyboard中指定的标识符
 *
 *  @return 指定identifer的控制器
 */
+ (__kindof UIViewController *)svv_viewControllerWithStoryBoardName:(NSString *)storyboardName identifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END
