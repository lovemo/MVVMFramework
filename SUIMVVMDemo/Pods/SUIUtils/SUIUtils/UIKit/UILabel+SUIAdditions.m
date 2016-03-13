//
//  UILabel+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UILabel+SUIAdditions.h"
#import "NSString+SUIAdditions.h"
#import "UIView+SUIAdditions.h"

@implementation UILabel (SUIAdditions)


- (CGFloat)sui_calculateHeight
{
    return [self.text sui_heightWithFont:self.font constrainedToWidth:self.sui_width];
}

- (CGSize)sui_calculateSize
{
    return [self.text sui_sizeWithFont:self.font constrainedToWidth:self.sui_width];
}

#pragma mark - hexRgbColor

- (NSString *)sui_textHexColor
{
    return @"0xffffff";
}

- (void)setSui_textHexColor:(NSString *)sui_textHexColor {
    NSScanner *scanner = [NSScanner scannerWithString:sui_textHexColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    self.textColor = [self sui_colorWithRGBHex:hexNum];
}

- (UIColor *)sui_colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

- (void)sui_addHorizontalLineWithColor:(UIColor *)lineColor lineTextColor:(UIColor *)lineTextColor range:(NSRange)range
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
