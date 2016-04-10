//
//  UIView+SMKEvents.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/5.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMKViewProtocol.h"
#import "SMKViewMangerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ViewEventsBlock)( );

@interface UIView (SMKEvents)

/**
 *  viewDelegate 传递事件
 */
@property (nullable, nonatomic, weak) id<SMKViewProtocol> viewDelegate;

/**
 *  block 传递事件
 */
@property (nonatomic, copy) ViewEventsBlock viewEventsBlock;

/**
 *  将view中的事件交由viewManger处理
 */
- (void)smk_viewWithViewManger:(id<SMKViewProtocol>)viewManger;

@end

NS_ASSUME_NONNULL_END

