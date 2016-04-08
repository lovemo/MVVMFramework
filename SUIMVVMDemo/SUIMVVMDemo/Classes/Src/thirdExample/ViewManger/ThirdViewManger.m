//
//  ThirdViewManger.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewManger.h"
#import "FirstVC.h"
#import "UIView+SMKEvents.h"
#import "UIView+SMKConfigure.h"

@interface ThirdViewManger ()<SMKViewProtocol>

@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation ThirdViewManger

// UIView的delegate方法
- (void)smk_view:(__kindof UIView *)view withEvents:(NSDictionary *)events {

    NSLog(@"----------%@", events);
    if ([[events allKeys] containsObject:@"jump"]) {
        FirstVC *firstVC = [UIViewController sui_viewControllerWithStoryboard:nil identifier:@"FirstVCID"];
        [view.sui_currentVC.navigationController pushViewController:firstVC animated:YES];
    }
    
}

- (ViewEventsBlock)smk_viewMangerWithEventBlockOfView:(__kindof UIView *)view {
    return ^(NSString *info){
        [view smk_configureViewWithModel:self.dict[@"model"]];
    };
}

// 得到模型数据
- (void)smk_viewMangerWithModel:(NSDictionary *(^)( ))dictBlock {
    if (dictBlock) {
        self.dict = dictBlock();
    }
}

@end
