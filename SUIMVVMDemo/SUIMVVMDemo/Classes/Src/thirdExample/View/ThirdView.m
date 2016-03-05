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

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:0.914 green:1.000 blue:0.604 alpha:1.000];
}

- (IBAction)testBtnClick:(UIButton *)sender {
    
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

- (IBAction)jumpOtherVC:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(smk_view:withEvents:)]) {
        [self.delegate smk_view:self withEvents:@{@"jump": @"vc"}];
    }
}

- (void)configureViewWithCustomObj:(id)obj {
    if (!obj) return;
    ThirdModel *thirdModel = (ThirdModel *)obj;
    self.testLabel.text = thirdModel.title;
}

@end
