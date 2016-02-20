//
//  ThirdView.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdView.h"

@interface ThirdView()


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


@end
