//
//  UIView+ViewDelegateAdditions.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/5.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMKViewProtocolDelegate.h"

NS_ASSUME_NONNULL_BEGIN


@interface UIView (ViewDelegateAdditions)

@property (nullable, nonatomic, weak) id<SMKViewProtocolDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

