//
//  FourthViewManger2.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/6.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "FourthViewManger2.h"
#import "SUIUtils.h"
#import "FourthView2.h"
#import "Masonry.h"


@interface FourthViewManger2 ()

/** fouthView */
@property (nonatomic, weak) FourthView2 *fourthView2;
/** mark */
@property (nonatomic, weak) UIView *fourthView;

@end

@implementation FourthViewManger2

#pragma mark lazy
- (FourthView2 *)fourthView2 {
    if (!_fourthView2) {
        FourthView2 *fourthView2 = [FourthView2 sui_loadInstanceFromNib];
        _fourthView2 = fourthView2;
    }
    return _fourthView2;
}

- (void)smk_viewMangerWithSuperView:(UIView *)superView {
    [superView addSubview:self.fourthView2];
}

// 根据自身需要得到外界的视图view
- (void)smk_viewMangerWithOtherSubViews:(NSDictionary *)viewInfos {
    
    UIView *view1 = viewInfos[@"view1"];
    self.fourthView = view1;
    
    [self.fourthView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 250));
        make.top.mas_equalTo(view1.mas_bottom).offset(20);
        make.left.mas_equalTo(view1);
        
    }];
    
}

// 根据外界view或model的变化重新布局自己所管理的字视图的位置
- (void)smk_viewMangerWithUpdateLayoutSubViews {
    
    CGFloat offset = arc4random_uniform(70) + 10;
    CGFloat wh = arc4random_uniform(200) + 50;
    CGSize size = CGSizeMake(wh, wh);
    [self.fourthView2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fourthView.mas_bottom).offset(offset);
        make.size.mas_equalTo(size);
    }];
    
    [self.fourthView2 setNeedsLayout];
    [UIView animateWithDuration:0.5 animations:^{
        [self.fourthView2 layoutIfNeeded];
    }];
}

@end
