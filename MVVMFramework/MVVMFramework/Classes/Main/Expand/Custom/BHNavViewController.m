//
//  BHNavViewController.m
//  HarmoniousCommunity
//
//  Created by love on 15/11/17.
//  Copyright © 2015年 love. All rights reserved.
//

#import "BHNavViewController.h"

@interface BHNavViewController ()

@end

@implementation BHNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // 导航条返回键带的title消失
//    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60)
//                                                       forBarMetrics:UIBarMetricsDefault];
    
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc]init];
    returnButtonItem.title = @"返回";
    viewController.navigationItem.backBarButtonItem = returnButtonItem;
    
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
      //  viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        
    }
    
    [super pushViewController:viewController animated:animated];
}
+ (void)initialize {
    [BHNavViewController setupNavTheme];
}
// 设置导航栏的主题
+(void)setupNavTheme{
    // 设置导航样式
    
    UINavigationBar *navBar = [UINavigationBar appearance
                               ];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.377 green:0.858 blue:1.000 alpha:1.000]];
    // 1.设置导航条的背景
    
    // 高度不会拉伸，但是宽度会拉伸
  //  [navBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    
    // 2.设置栏的字体
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor colorWithRed:1.000 green:0.485 blue:0.568 alpha:1.000];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    
    [navBar setTitleTextAttributes:att];

    // 设置状态栏的样式
    // xcode5以上，创建的项目，默认的话，这个状态栏的样式由控制器决定
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

@end
