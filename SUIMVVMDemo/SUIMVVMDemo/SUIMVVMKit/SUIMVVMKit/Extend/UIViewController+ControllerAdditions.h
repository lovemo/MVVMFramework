//
//  UIViewController+ControllerAdditions.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/10.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMKViewControllerProtocolDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ControllerAdditions)<SMKViewControllerProtocolDelegate>

@property (nonatomic,strong) __kindof NSObject *smk_viewModel;
@property (nonatomic,strong) __kindof NSObject *smk_viewManger;

@end
NS_ASSUME_NONNULL_END