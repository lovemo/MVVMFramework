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
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (ViewEventsBlock)viewEventsBlock {
    return objc_getAssociatedObject(self, @selector(viewEventsBlock));
}

- (void)setViewEventsBlock:(ViewEventsBlock)viewEventsBlock {
    objc_setAssociatedObject(self, @selector(viewEventsBlock), viewEventsBlock, OBJC_ASSOCIATION_COPY);
}

@end
