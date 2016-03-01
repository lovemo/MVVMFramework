//
//  UILabel+SVVAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/19.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UILabel+SVVAdditions.h"

@implementation UILabel (SVVAdditions)


#pragma mark - hexRgbColor

- (NSString *)svv_textHexColor
{
    return @"0xffffff";
}
- (void)setSvv_textHexColor:(NSString *)svv_textHexColor
{
    NSScanner *scanner = [NSScanner scannerWithString:svv_textHexColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    self.textColor = [self svv_colorWithRGBHex:hexNum];
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


- (void)svv_addHorizontalLineWithColor:(UIColor *)lineColor lineTextColor:(UIColor *)lineTextColor range:(NSRange)range
{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    UIColor *textColor = nil;
    lineTextColor == nil ? (textColor = self.textColor) : (textColor = lineTextColor);
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [attributedString addAttribute:NSStrikethroughColorAttributeName value:lineColor range:range];
    self.attributedText = attributedString;
}


@end
