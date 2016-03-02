//
//  UIImage+Extention.h
//  常用分类功能
//
//  Created by mac on 15-1-4.
//  Copyright (c) 2015年 lijianyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)
/**
 *  图片不让系统渲染
 *
 *  @param image 图片
 *
 *  @return 不被系统渲染的图片
 */
+(UIImage*)imageOrginal:(UIImage*)image;
/**
 *  裁剪带边框的圆形图片(当图片不是方正的，裁剪出来是椭圆，所以要求显示的imageView是方正的）
 *
 *  @param image 图片
 *  @param borderWidth 边框尺寸
 *  @param borderColor  边框颜色
 *
 *  @return 裁剪好得图片
 */

+ (instancetype)circleImage:(UIImage*)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  最大化裁剪成圆图(当图片不是方正的，裁剪出来是椭圆，所以要求显示的imageView是方正的）
 *
 *  @param image图片
 *
 *  @return 裁剪后的图片
 */
+(instancetype)circleImage:(UIImage*)image;
/**
 *  水印logo,logo默认距离右上角10px
 *
 *  @param image 图片
 *  @param logoName  logo图片名
 *  @param size  将来logo的尺寸
 *
 *  @return 水印后的图片
 */
+(instancetype)image:(UIImage*)image andLogoImage:(NSString*)logoName andLogoSize:(CGSize)size;
/**
 *  水印标题，标题默认位置，距离左上角10px
 *
 *  @param image图片
 *  @param description    标题文字
 *  @param textColor      文字颜色
 *  @param backGroudColor 文字背景色
 *  @param size           文字大小
 *
 *  @return 水印标题后的图片
 */
+(instancetype)image:(UIImage*)image andDescription:(NSString*)description andColor:(UIColor*)textColor andColor:(UIColor*)backGroudColor andFontSize:(CGFloat) size;
/**
 *  截屏
 *
 *  @param view 屏幕
 *
 *  @return 截取的图片
 */

+(UIImage*)subImage:(UIView*)view;
/**
 *  不变形拉伸图片
 *
 *  @param image图片
 *
 *  @return 拉伸后的图片
 */
+(instancetype)resizebleImage:(UIImage*)image;
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
@end
