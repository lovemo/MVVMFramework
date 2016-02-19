//
//  ThirdViewManger.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewManger.h"
#import "ThirdModel.h"
#import "FirstVC.h"
#import "BHNavViewController.h"

@implementation ThirdViewManger

- (ThirdView *)thirdView {
    if (_thirdView == nil) {
        ThirdView *thirdView = [ThirdView loadInstanceFromNib];
        thirdView.frame = CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, 200);
        _thirdView = thirdView;
    }
    return _thirdView;
}

- (instancetype)init {
    if (self = [super init]) {
        
        [PMKVObserver observeObject:self keyPath:@"thirdModel" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nonnull object, NSDictionary<NSString *,id> * _Nullable change, PMKVObserver * _Nonnull kvo) {
            
            ThirdModel *old = change[NSKeyValueChangeOldKey];
            ThirdModel *new = change[NSKeyValueChangeNewKey];
            if (old != new && (new == nil || ![old isEqual:new])) {
                NSLog(@"User's full name changed to %@", new.title);
            }
        }];

        __weak typeof(self.thirdView) weakThirdView =  self.thirdView;
        // btnClickBlock
        weakThirdView.btnClickBlock = ^() {
            weakThirdView.testLabel.text = self.thirdModel.title;
            NSLog(@"点我干嘛----");
        };
        // btnJumpBlock
        weakThirdView.btnJumpBlock = ^() {
            FirstVC *firstVC = [UIViewController viewControllerWithStoryBoardName:@"Main" identifier:@"FirstVCID"];
            [weakThirdView.viewController.navigationController pushViewController:firstVC animated:YES];
        };

    }
    return self;
}

@end
