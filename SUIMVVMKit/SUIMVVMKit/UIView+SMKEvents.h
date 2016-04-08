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
 *  delegate 传递事件
 */
@property (nullable, nonatomic, weak) id<SMKViewProtocol> delegate;

/**
 *  block 传递事件
 */
@property (nonatomic, copy) ViewEventsBlock viewEventsBlock;

- (void)smk_viewWithViewManger:(id<SMKViewProtocol>)viewManger;

@end

NS_ASSUME_NONNULL_END

