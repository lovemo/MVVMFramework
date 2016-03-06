//
//  FourthViewManger.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/6.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "FourthViewManger.h"
#import "SUIUtils.h"
#import "FourthView.h"
#import "Masonry.h"


@interface FourthViewManger ()

/** fouthView */
@property (nonatomic, weak) FourthView *fourthView;

@end

@implementation FourthViewManger

#pragma mark lazy
- (FourthView *)fourthView {
    if (!_fourthView) {
        FourthView *fourthView = [FourthView sui_loadInstanceFromNib];
        _fourthView = fourthView;
    }
    return _fourthView;
}

- (void)smk_viewMangerWithSuperView:(UIView *)superView {
    [superView addSubview:self.fourthView];
    [self.fourthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerY.mas_equalTo(superView).offset( -100);
        make.left.mas_equalTo(60);
    }];
    
}

- (UIView *)smk_viewMangerOfSubView {
    return self.fourthView;
}

- (void)smk_viewMangerWithLayoutSubViews:(void (^)())updateBlock {
    
    CGFloat left = arc4random_uniform(100) + 20;
    CGFloat height = arc4random_uniform(150) + 20;
    [self.fourthView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.height.mas_equalTo(height);
    }];
    
    [self.fourthView setNeedsLayout];
    [UIView animateWithDuration:0.5 animations:^{
        [self.fourthView layoutIfNeeded];
    }];
    
    if (updateBlock) {
        updateBlock();
    }
    
}

@end
