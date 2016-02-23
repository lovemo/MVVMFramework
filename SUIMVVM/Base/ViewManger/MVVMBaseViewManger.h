//
//  MVVMBaseViewManger.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/22.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVVMBaseViewManger : NSObject

/** 用于传递数据的基模型 */
@property (nonatomic, strong) NSObject *sui_model;

/**
 *  设置Controller的子视图的管理者为self
 *
 *  @param superView 一般指subView所在控制器的view
 */
- (void)handleViewMangerWithSuperView:(UIView *)superView;

/**
 *  设置subView的管理者为self
 *
 *  @param subView 管理的subView
 */
- (void)handleViewMangerWithSubView:(UIView *)subView;

/**
 *  设置添加subView的事件
 *
 *  @param view 管理的subView
 *  @param info 附带信息，用于区分调用
 */
- (void)handleViewMangerActionWithView:(UIView *)view info:(NSString *)info;

@end
