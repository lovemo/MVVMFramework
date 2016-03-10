//
//  SMKViewMangerProtocolDelegate.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/23.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#ifndef SMKViewMangerProtocolDelegate_h
#define SMKViewMangerProtocolDelegate_h
#import <UIKit/UIKit.h>

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

/**
 *  返回viewManger所管理的视图
 *
 *  @return viewManger所管理的视图
 */
- (__kindof UIView *)smk_viewMangerOfSubView;

/**
 *  得到其它viewManger所管理的subView，用于自己内部
 *
 *  @param views 其它的subViews
 */
- (void)smk_viewMangerWithOtherSubViews:(NSDictionary *)viewInfos;

/**
 *  需要重新布局subView时，更改subView的frame或者约束
 *
 *  @param block 更新布局完成的block
 */
- (void)smk_viewMangerWithLayoutSubViews:(void (^)( ))updateBlock;

/**
 *  使子视图更新到最新的布局约束或者frame
 */
- (void)smk_viewMangerWithUpdateLayoutSubViews;

/**
 *  将model数据传递给viewManger
 */
- (void)viewMangerWithModel:(NSDictionary * (^) ( ))dict;

@end

#endif /* SMKViewMangerProtocolDelegate_h */
