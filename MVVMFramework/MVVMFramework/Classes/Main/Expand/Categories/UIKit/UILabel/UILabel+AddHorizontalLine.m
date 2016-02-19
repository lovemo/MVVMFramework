//
//  UILabel+AddHorizontalLine.m
//  testMVVM
//
//  Created by yuantao on 16/2/2.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "UILabel+AddHorizontalLine.h"

@implementation UILabel (AddHorizontalLine)

- (void)addHorizontalLineWithColor:(UIColor *)lineColor lineTextColor:(UIColor *)lineTextColor range:(NSRange)range {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    UIColor *textColor = nil;
    lineTextColor == nil ? (textColor = self.textColor) : (textColor = lineTextColor);
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [attributedString addAttribute:NSStrikethroughColorAttributeName value:lineColor range:range];
    self.attributedText = attributedString;
    
}

@end
