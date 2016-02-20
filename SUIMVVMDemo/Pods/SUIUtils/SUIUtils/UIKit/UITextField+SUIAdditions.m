//
//  UITextField+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UITextField+SUIAdditions.h"

@implementation UITextField (SUIAdditions)


- (BOOL)sui_showKeyboard
{
    if (![self isFirstResponder])
    {
        return [self becomeFirstResponder];
    }
    return YES;
}
- (void)setSui_showKeyboard:(BOOL)sui_showKeyboard
{
    if (sui_showKeyboard && ![self isFirstResponder])
    {
        [self becomeFirstResponder];
    }
}

- (void)sui_dismissKeyboard
{
    if (self.isFirstResponder)
    {
        [self resignFirstResponder];
    }
}


@end
