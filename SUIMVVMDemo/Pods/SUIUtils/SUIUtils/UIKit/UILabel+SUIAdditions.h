//
//  UILabel+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (SUIAdditions)

/**
 *  set text hex color
 */
@property (assign,nonatomic) IBInspectable NSString *sui_textHexColor;

/**
 *  为UILabel添加中划线
 *
 *  @param lineColor     划线颜色
 *  @param lineTextColor 划线文本颜色
 *  @param range         划线范围
 */
- (void)sui_addHorizontalLineWithColor:(UIColor *)lineColor lineTextColor:(UIColor *)lineTextColor range:(NSRange)range;

- (CGFloat)sui_calculateHeight;

- (CGSize)sui_calculateSize;


@end

NS_ASSUME_NONNULL_END
