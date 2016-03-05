//
//  SMKViewMangerProtocolDelegate.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/23.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#ifndef SMKViewMangerProtocolDelegate_h
#define SMKViewMangerProtocolDelegate_h

@protocol SMKViewMangerProtocolDelegate <NSObject>

@optional

/**
 *  设置Controller的子视图的管理者为self
 *
 *  @param superView 一般指subView所在控制器的view
 */
- (void)smk_viewMangerWithSuperView:(UIView *)superView;

/**
 *  设置subView的管理者为self
 *
 *  @param subView 管理的subView
 */
- (void)smk_viewMangerWithSubView:(UIView *)subView;

/**
 *  设置添加subView的事件
 *
 *  @param view 管理的subView
 *  @param info 附带信息，用于区分调用
 */
- (void)smk_viewMangerWithHandleOfSubView:(UIView *)subView info:(NSString *)info;

@end

#endif /* SMKViewMangerProtocolDelegate_h */
