//
//  ThirdVC.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdVC.h"
#import "ThirdViewModel.h"
#import "ThirdViewManger.h"
#import "FirstVC.h"
#import "ThirdView.h"
#import "UIView+SMKEvents.h"
#import "UIView+SMKConfigure.h"

@interface ThirdVC ()

@property (nonatomic, strong) ThirdViewManger *thirdViewManger;
@property (nonatomic, strong) ThirdViewModel *viewModel;
@property (nonatomic, weak) ThirdView *thirdView;
@end

@implementation ThirdVC

- (ThirdView *)thirdView {
    if (_thirdView == nil) {
        ThirdView *thirdView = [ThirdView sui_loadInstanceFromNib];
        thirdView.frame = CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, 200);
        [self.view addSubview:(_thirdView = thirdView)];
    }
    return _thirdView;
}

- (ThirdViewManger *)thirdViewManger {
    if (_thirdViewManger == nil) {
        _thirdViewManger = [[ThirdViewManger alloc]init];
    }
    return _thirdViewManger;
}

- (ThirdViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[ThirdViewModel alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MVVM Example";

    // 将thirdView的事件处理者代理给thirdViewManger (代理方式)
    [self.thirdView smk_viewWithViewManger:self.thirdViewManger];
    
    // self.thirdView.viewEventsBlock （block方式）
    self.thirdView.viewEventsBlock = [self.thirdViewManger smk_viewMangerWithViewEventBlockOfInfos:@{@"view" : self.thirdView}];
    
    // viewManger ---->  <-----  viewModel 之间通过代理方式交互
    self.thirdViewManger.viewMangerDelegate = self.viewModel;
    self.viewModel.viewModelDelegate = self.thirdViewManger;
    
    // viewManger ---->  <-----  viewModel 之间通过block方式交互
    self.thirdViewManger.viewMangerInfosBlock = [self.viewModel smk_viewModelWithViewMangerBlockOfInfos:@{@"info" : @"viewManger"}];
}

- (IBAction)clickBtnAction:(UIButton *)sender {
    
    // 根据viewModel配置view
    [self.thirdView smk_configureViewWithViewModel:self.viewModel];

}

@end
