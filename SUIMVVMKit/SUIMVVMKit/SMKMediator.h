//
//  SMKMediator.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/15.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKViewModelProtocol.h"
#import "SMKViewMangerProtocol.h"

@interface SMKMediator : NSObject

/**
 *  viewModel
 */
@property (nonatomic, strong) NSObject<SMKViewModelProtocol> *viewModel;

/**
 *  viewManger
 */
@property (nonatomic, strong) NSObject<SMKViewMangerProtocol> *viewManger;

/**
 *  初始化
 */
- (instancetype)initWithViewModel:(id<SMKViewModelProtocol>)viewModel viewManger:(id<SMKViewMangerProtocol>)viewManger;

+ (instancetype)mediatorWithViewModel:(id<SMKViewModelProtocol>)viewModel viewManger:(id<SMKViewMangerProtocol>)viewManger;

/**
 *  将infos通知viewModel
 */
- (void)noticeViewModelWithInfos:(NSDictionary *)infos;

/**
 *  将infos通知viewMnager
 */
- (void)noticeViewMangerWithInfos:(NSDictionary *)infos;

@end
