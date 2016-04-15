//
//  ThirdView.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdView.h"
#import "ThirdModel.h"
#import "UIView+SMKEvents.h"
#import "UIView+SMKConfigure.h"
#import "ThirdViewModel.h"

@interface ThirdView()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@end

@implementation ThirdView

// 按钮事件
- (IBAction)testBtnClick:(UIButton *)sender {
        // 传递事件
//    if (self.delegate && [self.delegate respondsToSelector:@selector(smk_view:withEvents:)]) {
//        [self.delegate smk_view:self withEvents:@{@"click": @"btn"}];
//    }

    if (self.viewEventsBlock) {
        self.viewEventsBlock(@"btnClick");
    }
}

// 按钮事件
- (IBAction)jumpOtherVC:(UIButton *)sender {
    // 传递事件
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(smk_view:withEvents:)]) {
        [self.viewDelegate smk_view:self withEvents:@{@"jump": @"vc"}];
    }
}

//// 根据模型数据配置View
//- (void)smk_configureViewWithModel:(id)model {
//    ThirdModel *thirdModel = (ThirdModel *)model;
//    self.testLabel.text = thirdModel.title;
//}

- (void)smk_configureViewWithViewModel:(id<SMKViewModelProtocol>)viewModel {
    
    [viewModel smk_viewModelWithModelBlcok:^(id model) {
        ThirdModel *thirdModel = (ThirdModel *)model;
        self.testLabel.text = thirdModel.title;
    }];
}

@end
