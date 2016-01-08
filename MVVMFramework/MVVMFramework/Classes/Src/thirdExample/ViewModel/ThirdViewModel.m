//
//  ThirdViewModel.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewModel.h"

@implementation ThirdViewModel
- (instancetype)init {
    if (self = [super init]) {
        self.model = [[ThirdModel alloc]init];
        
        [PMKVObserver observeObject:self.model keyPath:@"name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nonnull object, NSDictionary<NSString *,id> * _Nullable change, PMKVObserver * _Nonnull kvo) {
            NSLog(@"新值--%@",change[NSKeyValueChangeNewKey]);
        }];
    }
    return self;
}

@end
