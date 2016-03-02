//
//  UIImage+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SUIAdditions)


- (UIImage * __null_unspecified)sui_imageWithTintColor:(UIColor *)tintColo; // kCGBlendModeDestinationIn
- (UIImage * __null_unspecified)sui_imageWithGradientTintColor:(UIColor *)tintColo; // kCGBlendModeOverlay
- (UIImage * __null_unspecified)sui_imageWithTintColor:(UIColor *)tintColo blendMode:(CGBlendMode)blendMode;


@end

NS_ASSUME_NONNULL_END
