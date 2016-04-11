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

//@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation ThirdViewManger

#pragma mark UIView的delegate方法
- (void)smk_view:(__kindof UIView *)view withEvents:(NSDictionary *)events {

    NSLog(@"----------%@", events);
    if ([[events allKeys] containsObject:@"jump"]) {
        FirstVC *firstVC = [UIViewController sui_viewControllerWithStoryboard:nil identifier:@"FirstVCID"];
        [view.sui_currentVC.navigationController pushViewController:firstVC animated:YES];
    }
    
}

#pragma mark ViewEvents Block
- (ViewEventsBlock)smk_viewMangerWithViewEventBlockOfInfos:(NSDictionary *)infos {
    
    return ^(NSString *info){
        
        if (self.viewMangerInfosBlock) {
            self.viewMangerInfosBlock();
        }
        
        if (self.viewMangerDelegate && [self.viewMangerDelegate respondsToSelector:@selector(smk_viewManger:withInfos:)]) {
            [self.viewMangerDelegate smk_viewManger:self withInfos: @{@"info" : @"哈哈，你好ViewModel，我是viewManger，我被点击了"}];
        }
        
    //    NSLog(@"%@",info);
     //   [view smk_configureViewWithModel:self.dict[@"model"]];
    };
}

#pragma mark ViewModel delegate
- (void)smk_viewModel:(id)viewModel withInfos:(NSDictionary *)infos {
    NSLog(@"%@",infos);
}

//// 得到模型数据
//- (void)smk_viewMangerWithModel:(NSDictionary *(^)( ))dictBlock {
//    if (dictBlock) {
//        self.dict = dictBlock();
//    }
//}

@end
