//
//  ThirdView.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdView.h"
#import "ThirdModel.h"

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
    if (self.btnJumpBlock) {
        self.btnJumpBlock();
    }
}

- (void)configureViewWithCustomObj:(id)obj {
    ThirdModel *thirdModel = (ThirdModel *)obj;
    self.testLabel.text = thirdModel.title;
}

@end
