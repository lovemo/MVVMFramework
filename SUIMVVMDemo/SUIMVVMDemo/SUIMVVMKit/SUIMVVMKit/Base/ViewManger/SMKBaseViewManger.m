//
//  SMKBaseViewManger.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/22.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "SMKBaseViewManger.h"

@implementation SMKBaseViewManger

- (instancetype)init {
    if (self = [super init]) {
        [self smk_viewMangerWithSubView:nil];
    }
    return self;
}

@end
