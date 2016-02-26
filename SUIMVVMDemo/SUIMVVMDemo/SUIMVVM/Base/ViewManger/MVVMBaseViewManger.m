//
//  MVVMBaseViewManger.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/22.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "MVVMBaseViewManger.h"

@implementation MVVMBaseViewManger

- (instancetype)init {
    if (self = [super init]) {
        [self handleViewMangerWithSubView:nil];
    }
    return self;
}

@end
