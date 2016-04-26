//
//  SMKViewMangerProtocol.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/23.
//  Copyright © 2016年 lovemo. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef void (^ViewEventsBlock)( );

/**
 *  将自己的信息返回给ViewModel的block
 */
typedef void (^ViewModelInfosBlock)( );

/**
 *  将自己的信息返回给ViewManger的block
 */
typedef void (^ViewMangerInfosBlock)( );


@protocol SMKViewMangerProtocol <NSObject>

@optional


- (void)smk_notice;

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
- (void)smk_viewMangerWithModel:(NSDictionary * (^) ( ))dictBlock;

/**
 *  处理viewBlock事件
 */
- (ViewEventsBlock)smk_viewMangerWithViewEventBlockOfInfos:(NSDictionary *)infos;

/**
 *  处理ViewModelInfosBlock
 */
- (ViewModelInfosBlock)smk_viewMangerWithViewModelBlockOfInfos:(NSDictionary *)infos;

/**
 *  处理ViewMangerInfosBlock
 */
- (ViewMangerInfosBlock)smk_viewMangerWithOtherViewMangerBlockOfInfos:(NSDictionary *)infos;

/**
 *  将viewManger中的信息通过代理传递给ViewModel
 *
 *  @param viewManger   viewManger自己
 *  @param infos 描述信息
 */
- (void)smk_viewManger:(id)viewManger withInfos:(NSDictionary *)infos;


@end

