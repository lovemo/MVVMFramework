//
//  SMKMediator.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/15.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "SMKMediator.h"
#import "NSObject+SMKProperties.h"


@implementation SMKMediator

- (instancetype)initWithViewModel:(id<SMKViewModelProtocol>)viewModel viewManger:(id<SMKViewMangerProtocol>)viewManger {
    if (self = [super init]) {
        self.viewModel = (NSObject<SMKViewModelProtocol> *)viewModel;
        self.viewManger = (NSObject<SMKViewMangerProtocol> *)viewManger;
    }
    return self;
}

+ (instancetype)mediatorWithViewModel:(id<SMKViewModelProtocol>)viewModel viewManger:(id<SMKViewMangerProtocol>)viewManger {
    return [[self alloc]initWithViewModel:viewModel viewManger:viewManger];
}

- (void)noticeViewModelWithInfos:(NSDictionary *)infos {
    self.viewModel.smk_viewModelInfos  = infos;
}

- (void)noticeViewMangerWithInfos:(NSDictionary *)infos {
    self.viewManger.smk_viewMangerInfos  = infos;
}

@end
