//
//  ThirdViewManger.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewManger.h"
#import "FirstVC.h"
#import "ThirdView.h"
#import "UIView+ViewDelegateAdditions.h"

@interface ThirdViewManger ()<SMKViewProtocolDelegate>

@property (nonatomic, weak) ThirdView *thirdView;
@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation ThirdViewManger

- (ThirdView *)thirdView {
    if (_thirdView == nil) {
        ThirdView *thirdView = [ThirdView sui_loadInstanceFromNib];
        _thirdView = thirdView;
        _thirdView.delegate = self;
        
        __weak typeof(_thirdView) weakThirdView =  _thirdView;
        __weak typeof(self) weakSelf = self;
        _thirdView.viewEventsBlock = ^(NSString *str) {
            NSLog(@"%@",str);
            // 可以根据传入的信息，判断分写不同的响应方法
            [weakSelf smk_viewMangerWithHandleOfSubView:weakThirdView info:@"click"];
        };
        
    }
    return _thirdView;
}

//// 两种消息传递方式，开发时任选其一即可，处理View中自定义的事件
//- (void)smk_viewMangerWithSubView:(UIView *)subView {
//    
//    __weak typeof(self.thirdView) weakThirdView =  self.thirdView;
//    __weak typeof(self) weakSelf = self;
//    
//    // btnClickBlock
//    weakThirdView.viewEventsBlock = ^(NSString *str) {
//        NSLog(@"%@",str);
//        // 可以根据传入的信息，判断分写不同的响应方法
//        [weakSelf smk_viewMangerWithHandleOfSubView:weakThirdView info:@"click"];
//    };
//}

// UIView的delegate方法 ，两种消息传递方式，开发时任选其一即可 根据传入的events信息处理事件
- (void)smk_view:(__kindof UIView *)view withEvents:(NSDictionary *)events {

    NSLog(@"----------%@", events);
    
    if ([[events allKeys] containsObject:@"jump"]) {
        FirstVC *firstVC = [UIViewController sui_viewControllerWithStoryboard:nil identifier:@"FirstVCID"];
        [view.sui_currentVC.navigationController pushViewController:firstVC animated:YES];
    }
    
}

// 得到父视图，添加subView -> superView
- (void)smk_viewMangerWithSuperView:(UIView *)superView {
    self.thirdView.frame = CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, 200);
    [superView addSubview:self.thirdView];
}

// 根据传入的info设置添加subView的事件
- (void)smk_viewMangerWithHandleOfSubView:(UIView *)view info:(NSString *)info {
    
    if ([info isEqualToString:@"click"]) {
        [view configureViewWithCustomObj:self.dict[@"model"]];
    }
}
// 得到模型数据
- (void)smk_viewMangerWithModel:(NSDictionary *(^)( ))dictBlock {
    if (dictBlock) {
        self.dict = dictBlock();
    }
}

@end
