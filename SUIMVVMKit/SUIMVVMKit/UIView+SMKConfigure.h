//
//  UIView+SMKConfigure.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/22.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMKViewModelProtocol.h"

@interface UIView (SMKConfigure)

/**
 *  根据model配置UIView，设置UIView内容
 */
- (void)smk_configureViewWithModel:(id)model;

/**
 *  根据viewModel配置UIView，设置UIView内容
 */
- (void)smk_configureViewWithViewModel:(id<SMKViewModelProtocol>)viewModel;


@end
