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

- (instancetype)init {
    if (self = [super init]) {
        
        [PMKVObserver observeObject:self keyPath:@"thirdModel" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nonnull object, NSDictionary<NSString *,id> * _Nullable change, PMKVObserver * _Nonnull kvo) {
            
            ThirdModel *old = change[NSKeyValueChangeOldKey];
            ThirdModel *new = change[NSKeyValueChangeNewKey];
            if (old != new && (new == nil || ![old isEqual:new])) {
                NSLog(@"User's full name changed to %@", new.title);
            }
        }];

        
        ThirdView *thirdView = [ThirdView loadInstanceFromNib];
        thirdView.frame = CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, 200);
        
        __weak typeof(thirdView) weakSelf =  thirdView;
        // btnClickBlock
        thirdView.btnClickBlock = ^() {
            weakSelf.testLabel.text = self.thirdModel.title;
            NSLog(@"点我干嘛----");
        };
        // btnJumpBlock
        FirstVC *firstVC = [UIViewController viewControllerWithStoryBoardName:@"Main" identifier:@"FirstVCID"];
        thirdView.btnJumpBlock = ^() {
            [weakSelf.viewController.navigationController pushViewController:firstVC animated:YES];
        };
        
        _thirdView = thirdView;

    }
    return self;
}

@end
