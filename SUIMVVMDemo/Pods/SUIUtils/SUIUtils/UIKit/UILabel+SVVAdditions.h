//
//  UILabel+SVVAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/19.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UILabel (SVVAdditions)


// set text hex color
@property (assign,nonatomic) IBInspectable NSString *svv_textHexColor;


/**
 *  为UILabel添加中划线
 *
 *  @param lineColor     划线颜色
 *  @param lineTextColor 划线文本颜色
 *  @param range         划线范围
 */
- (void)svv_addHorizontalLineWithColor:(UIColor *)lineColor lineTextColor:(UIColor *)lineTextColor range:(NSRange)range;



@end
