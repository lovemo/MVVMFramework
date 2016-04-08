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

    [self.thirdView smk_viewWithViewManger:self.thirdViewManger];
    self.thirdView.viewEventsBlock = [self.thirdViewManger smk_viewMangerWithEventBlockOfView:self.thirdView];
}

- (IBAction)clickBtnAction:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [self.viewModel smk_viewModelWithProgress:nil success:^(id responseObject) {
        [weakSelf.thirdViewManger smk_viewMangerWithModel:^NSDictionary *{
            return @{@"model" : [weakSelf.viewModel getRandomData:responseObject]};
        }];
    } failure:nil];
    
}

@end
