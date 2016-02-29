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

@interface ThirdViewManger ()
@property (nonatomic, weak) ThirdView *thirdView;
@end

@implementation ThirdViewManger

- (ThirdView *)thirdView {
    if (_thirdView == nil) {
        ThirdView *thirdView = [ThirdView svv_loadInstanceFromNib];
        _thirdView = thirdView;
    }
    return _thirdView;
}

- (void)vm_handleViewMangerWithSubView:(UIView *)subView {
    
    __weak typeof(self.thirdView) weakThirdView =  self.thirdView;
    __weak typeof(self) weakSelf = self;
    
    // btnClickBlock
    weakThirdView.btnClickBlock = ^() {
        [weakSelf vm_handleViewMangerActionWithView:weakThirdView info:@"click"];
    };
    
    // btnJumpBlock
    weakThirdView.btnJumpBlock = ^() {
        [weakSelf vm_handleViewMangerActionWithView:weakThirdView info:@"jump"];
    };
    
}

- (void)vm_handleViewMangerWithSuperView:(UIView *)superView {
    self.thirdView.frame = CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, 200);
    [superView addSubview:self.thirdView];
}

- (void)vm_handleViewMangerActionWithView:(UIView *)view info:(NSString *)info {
    if ([info isEqualToString:@"click"]) {
        [view configureViewWithCustomObj:self.vm_model];
        
    } else {
        FirstVC *firstVC = [UIViewController svv_viewControllerWithStoryBoardName:@"Main" identifier:@"FirstVCID"];
        [view.sui_currentVC.navigationController pushViewController:firstVC animated:YES];
    }
}

@end
