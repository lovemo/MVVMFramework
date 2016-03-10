//
//  ThirdView.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdView.h"
#import "ThirdModel.h"
#import "UIView+ViewDelegateAdditions.h"

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(smk_view:withEvents:)]) {
        [self.delegate smk_view:self withEvents:@{@"jump": @"vc"}];
    }
}

// 根据模型数据配置View
- (void)configureViewWithCustomObj:(id)obj {
    if (!obj) return;
    ThirdModel *thirdModel = (ThirdModel *)obj;
    self.testLabel.text = thirdModel.title;
}

@end
