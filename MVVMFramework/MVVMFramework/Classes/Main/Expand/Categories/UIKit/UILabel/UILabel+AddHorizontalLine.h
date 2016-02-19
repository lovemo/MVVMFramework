//
//  UILabel+AddHorizontalLine.h
//  testMVVM
//
//  Created by yuantao on 16/2/2.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AddHorizontalLine)
/**
 *  为UILabel添加中划线
 *
 *  @param lineColor     划线颜色
 *  @param lineTextColor 划线文本颜色
 *  @param range         划线范围
 */
- (void)addHorizontalLineWithColor:(UIColor *)lineColor lineTextColor:(UIColor *)lineTextColor range:(NSRange)range;

@end
