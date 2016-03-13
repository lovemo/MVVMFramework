//
//  UIControl+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIControl+SUIAdditions.h"
#import "NSObject+SUIAdditions.h"

@implementation UIControl (SUIAdditions)


- (BOOL)sui_enabled
{
    return self.enabled;
}
- (void)setSui_enabled:(BOOL)sui_enabled
{
    if (self.enabled != sui_enabled) {
        self.enabled = sui_enabled;
    }
}

- (BOOL)sui_selected
{
    return self.selected;
}
- (void)setSui_selected:(BOOL)sui_selected
{
    if (self.selected != sui_selected) {
        self.selected = sui_selected;
    }
}

- (BOOL)sui_highlighted
{
    return self.highlighted;
}
- (void)setSui_highlighted:(BOOL)sui_highlighted
{
    if (self.highlighted != sui_highlighted) {
        self.highlighted = sui_highlighted;
    }
}


- (void)sui_click:(void (^)(void))cb
{
    [self sui_setAssociatedCopyObject:cb key:@selector(sui_handleClick)];
    [self addTarget:self action:@selector(sui_handleClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)sui_handleClick
{
    void (^clickBlock)(void) = [self sui_getAssociatedObjectWithKey:_cmd];
    if (clickBlock) clickBlock();
}

- (void)sui_controlEvents:(UIControlEvents)controlEvents cb:(void (^)(void))cb
{
    [self sui_setAssociatedCopyObject:cb key:@selector(sui_handleControlEvents)];
    [self addTarget:self action:@selector(sui_handleClick) forControlEvents:controlEvents];
}
- (void)sui_handleControlEvents
{
    void (^controlEventsBlock)(void) = [self sui_getAssociatedObjectWithKey:_cmd];
    if (controlEventsBlock) controlEventsBlock();
}


@end
