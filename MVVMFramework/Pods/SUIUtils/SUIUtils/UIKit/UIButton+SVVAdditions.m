//
//  UIButton+SVVAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/19.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIButton+SVVAdditions.h"

@implementation UIButton (SVVAdditions)


#pragma mark - hexRgbColor

- (NSString *)svv_titleHexColor
{
    return @"0xffffff";
}
- (void)setSvv_titleHexColor:(NSString *)svv_titleHexColor
{
    NSScanner *scanner = [NSScanner scannerWithString:svv_titleHexColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    [self setTitleColor:[self svv_colorWithRGBHex:hexNum] forState:UIControlStateNormal];
}

- (UIColor *)svv_colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


@end
