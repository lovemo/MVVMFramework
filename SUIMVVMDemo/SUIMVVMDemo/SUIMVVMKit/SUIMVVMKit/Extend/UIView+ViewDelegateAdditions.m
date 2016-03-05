//
//  UIView+ViewDelegateAdditions.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/5.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "UIView+ViewDelegateAdditions.h"
#import <objc/runtime.h>

@implementation UIView (ViewDelegateAdditions)

- (id<SMKViewProtocolDelegate>)delegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDelegate:(id<SMKViewProtocolDelegate>)delegate {
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
