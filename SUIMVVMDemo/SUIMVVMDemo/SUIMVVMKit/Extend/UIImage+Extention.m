//
//  UIImage+Extention.m
//  常用分类功能
//
//  Created by mac on 15-1-4.
//  Copyright (c) 2015年 lijianyi. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)
/**
 *  图片不让系统渲染
 *
 *  @param image图片
 *
 *  @return 不被系统渲染的图片
 */
+(UIImage *)imageOrginal:(UIImage*)image{

    //    返回不被系统渲染的图片
    image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

/**
 *  裁剪带边框的圆形图片（当图片不是方正的，裁剪出来是椭圆，所以要求显示的imageView是方正的）
 *
 *  @param image图片
 *  @param borderWidth 边框尺寸
 *  @param borderColor  边框颜色
 *
 *  @return 裁剪好得图片
 */
+ (instancetype)circleImage:(UIImage*)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    
    CGSize max=CGSizeMake(image.size.width+borderWidth*2, image.size.height+borderWidth*2);
    //   创建bitmap图形上下文,相当于空白的画布，NO表示透明，1表示可以缩放
    UIGraphicsBeginImageContextWithOptions(max, NO, 0);
    
    //    获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //    绘图大圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, max.width, max.height));
    [borderColor set];
    //    渲染
    CGContextFillPath(ctx);
    
    //    绘制小圆
    CGContextAddEllipseInRect(ctx, CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height));
    //    裁剪,仅对之后再画上去的有作用
    CGContextClip(ctx);
    
    //    画图片
    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    //    取出图片
    UIImage* newIcon=UIGraphicsGetImageFromCurrentImageContext();
    //    结束上下文
    UIGraphicsEndImageContext();
    return newIcon;
}
/**
 *  最大化裁剪成圆图,(当图片不是方正的，裁剪出来是椭圆，所以要求显示的imageView是方正的）

 *
 *  @param image图片
 *
 *  @return 裁剪后的图片
 */
+(instancetype)circleImage:(UIImage*)image{
    
    //    创建图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //    获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //    画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, image.size.width, image.size.height));
    //    裁剪
    CGContextClip(ctx);
    //   画图片
    [image drawAtPoint:CGPointMake(0, 0)];
    //    取出新图片
    UIImage* newImage=UIGraphicsGetImageFromCurrentImageContext();
    //    结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
    
}
/**
 *  水印logo,logo默认距离右上角10px
 *
 *  @param image图片
 *  @param logoName  logo图片名
 *  @param size  将来logo的尺寸
 *
 *  @return 水印后的图片
 */
+(instancetype)image:(UIImage*)image andLogoImage:(NSString*)logoName andLogoSize:(CGSize)size{
    
 
    //    创建图形上下文，透明，不缩放
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //    画图
    [image drawAtPoint:CGPointMake(0, 0)];
    //    设置logo的frame
    CGFloat margin=10;
    CGFloat logoX=image.size.width-size.width-margin;
    CGFloat logoY=margin;
    
    //    获取logo图片
    UIImage* logo=[UIImage imageNamed:logoName];
    //    画logo
    [logo drawInRect:CGRectMake(logoX, logoY, size.width, size.height)];
    //    取出图片
    UIImage* newImage=UIGraphicsGetImageFromCurrentImageContext();
    //    结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
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
+(instancetype)image:(UIImage*)image andDescription:(NSString*)description andColor:(UIColor*)textColor andColor:(UIColor*)backGroudColor andFontSize:(CGFloat) size{
    
    //  获取上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //    画图
    [image drawAtPoint:CGPointMake(0, 0)];
    //    画文字
    CGFloat margin=10;
    NSDictionary* dic=@{NSFontAttributeName: [UIFont systemFontOfSize:size],
                        NSForegroundColorAttributeName:textColor,
                        NSBackgroundColorAttributeName:backGroudColor};
    [description drawAtPoint:CGPointMake(margin, margin) withAttributes:dic];
    //    取出图片
    UIImage* newImage=UIGraphicsGetImageFromCurrentImageContext();
    //    结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
/**
 *  截屏
 *
 *  @param view 屏幕
 *
 *  @return 截取的图片
 */
+(UIImage*)subImage:(UIView*)view{
    
    //    创建图形上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    //    获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //    将layer画到画板上
    [view.layer renderInContext:ctx];
    
    //    取出图片
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    //    结束图形上下文
    UIGraphicsEndImageContext();
    return image;
    
    
}
/**
 *  不变形拉伸图片
 *
 *  @param image图片
 *
 *  @return 拉伸后的图片
 */

+(instancetype)resizebleImage:(UIImage*)image{
    
    
    //    该方法会自动将下边与右边减一像素，拉伸时用这一像素去填充，保证图片不变形
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    
}
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
