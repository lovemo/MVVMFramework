//
//  UIView+SMKEvents.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/5.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "UIView+SMKEvents.h"
#import <objc/runtime.h>

@implementation UIView (SMKEvents)

- (id<SMKViewProtocol>)delegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDelegate:(id<SMKViewProtocol>)delegate {
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (ViewEventsBlock)viewEventsBlock {
    return objc_getAssociatedObject(self, @selector(viewEventsBlock));
}

- (void)setViewEventsBlock:(ViewEventsBlock)viewEventsBlock {
    objc_setAssociatedObject(self, @selector(viewEventsBlock), viewEventsBlock, OBJC_ASSOCIATION_COPY);
}

- (void)smk_viewWithViewManger:(id<SMKViewProtocol>)viewManger {
    if (viewManger) {
        self.delegate = viewManger;
    }
}

@end
