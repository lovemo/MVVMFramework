//
//  UIButton+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIButton+SUIAdditions.h"
#import "UIImage+SUIAdditions.h"

@implementation UIButton (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Normal
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Normal

- (NSString *)sui_normalTitle
{
    return [self titleForState:UIControlStateNormal];
}
- (void)setSui_normalTitle:(NSString *)sui_normalTitle
{
    [self setTitle:sui_normalTitle forState:UIControlStateNormal];
}

- (UIColor *)sui_normalTitleColo
{
    return [self titleColorForState:UIControlStateNormal];
}
- (void)setSui_normalTitleColo:(UIColor *)sui_normalTitleColo
{
    [self setTitleColor:sui_normalTitleColo forState:UIControlStateNormal];
}

- (UIImage *)sui_normalImage
{
    return [self imageForState:UIControlStateNormal];
}
- (void)setSui_normalImage:(UIImage *)sui_normalImage
{
    [self setImage:sui_normalImage forState:UIControlStateNormal];
}

- (UIImage *)sui_normalBackgroundImage
{
    return [self backgroundImageForState:UIControlStateNormal];
}
- (void)setSui_normalBackgroundImage:(UIImage *)sui_normalBackgroundImage
{
    [self setBackgroundImage:sui_normalBackgroundImage forState:UIControlStateNormal];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Highlighted
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Highlighted

- (NSString *)sui_highlightedTitle
{
    return [self titleForState:UIControlStateHighlighted];
}
- (void)setSui_highlightedTitle:(NSString *)sui_highlightedTitle
{
    [self setTitle:sui_highlightedTitle forState:UIControlStateHighlighted];
}

- (UIColor *)sui_highlightedTitleColo
{
    return [self titleColorForState:UIControlStateHighlighted];
}
- (void)setSui_highlightedTitleColo:(UIColor *)sui_highlightedTitleColo
{
    [self setTitleColor:sui_highlightedTitleColo forState:UIControlStateHighlighted];
}

- (UIImage *)sui_highlightedImage
{
    return [self imageForState:UIControlStateHighlighted];
}
- (void)setSui_highlightedImage:(UIImage *)sui_highlightedImage
{
    [self setImage:sui_highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)sui_highlightedBackgroundImage
{
    return [self backgroundImageForState:UIControlStateHighlighted];
}
- (void)setSui_highlightedBackgroundImage:(UIImage *)sui_highlightedBackgroundImage
{
    [self setBackgroundImage:sui_highlightedBackgroundImage forState:UIControlStateHighlighted];
    
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Selected
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Selected

- (NSString *)sui_selectedTitle
{
    return [self titleForState:UIControlStateSelected];
}
- (void)setSui_selectedTitle:(NSString *)sui_selectedTitle
{
    [self setTitle:sui_selectedTitle forState:UIControlStateSelected];
}

- (UIColor *)sui_selectedTitleColo
{
    return [self titleColorForState:UIControlStateSelected];
}
- (void)setSui_selectedTitleColo:(UIColor *)sui_selectedTitleColo
{
    [self setTitleColor:sui_selectedTitleColo forState:UIControlStateSelected];
}

- (UIImage *)sui_selectedImage
{
    return [self imageForState:UIControlStateSelected];
}
- (void)setSui_selectedImage:(UIImage *)sui_selectedImage
{
    [self setImage:sui_selectedImage forState:UIControlStateSelected];
}

- (UIImage *)sui_selectedBackgroundImage
{
    return [self backgroundImageForState:UIControlStateSelected];
}
- (void)setSui_selectedBackgroundImage:(UIImage *)sui_selectedBackgroundImage
{
    [self setBackgroundImage:sui_selectedBackgroundImage forState:UIControlStateSelected];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Disabled
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Disabled

- (NSString *)sui_disabledTitle
{
    return [self titleForState:UIControlStateDisabled];
}
- (void)setSui_disabledTitle:(NSString *)sui_disabledTitle
{
    [self setTitle:sui_disabledTitle forState:UIControlStateDisabled];
}

- (UIColor *)sui_disabledTitleColo
{
    return [self titleColorForState:UIControlStateDisabled];
}
- (void)setSui_disabledTitleColo:(UIColor *)sui_disabledTitleColo
{
    [self setTitleColor:sui_disabledTitleColo forState:UIControlStateDisabled];
}

- (UIImage *)sui_disabledImage
{
    return [self imageForState:UIControlStateDisabled];
}
- (void)setSui_disabledImage:(UIImage *)sui_disabledImage
{
    [self setImage:sui_disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)sui_disabledBackgroundImage
{
    return [self backgroundImageForState:UIControlStateDisabled];
}
- (void)setSui_disabledBackgroundImage:(UIImage *)sui_disabledBackgroundImage
{
    [self setBackgroundImage:sui_disabledBackgroundImage forState:UIControlStateDisabled];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Padding & Insets
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Padding & Insets

- (CGFloat)sui_padding
{
    UIEdgeInsets curInsets = self.contentEdgeInsets;
    if (curInsets.left == curInsets.right) {
        return curInsets.left;
    }
    return 0;
}
- (void)setSui_padding:(CGFloat)sui_padding
{
    self.contentEdgeInsets = UIEdgeInsetsMake(0, sui_padding, 0, sui_padding);
    [self sizeToFit];
}

- (UIEdgeInsets)sui_insets
{
    return self.contentEdgeInsets;
}
- (void)setSui_insets:(UIEdgeInsets)sui_insets
{
    self.contentEdgeInsets = sui_insets;
    [self sizeToFit];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  TintColor
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - TintColor

- (UIColor *)sui_imageTintColor
{
    return nil;
}
- (void)setSui_imageTintColor:(UIColor *)sui_imageTintColor
{
    if (sui_imageTintColor) {
        UIImage *curImage = [[self currentImage] sui_imageWithGradientTintColor:sui_imageTintColor];
        self.sui_normalImage = curImage;
    }
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Resizable
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Resizable

- (BOOL)sui_resizableImage
{
    self.sui_resizableImage = YES;
    return YES;
}
- (void)setSui_resizableImage:(BOOL)sui_resizableImage
{
    if (sui_resizableImage) {
        UIEdgeInsets curInsets = UIEdgeInsetsMake(self.currentImage.size.height/2-1,
                                                  self.currentImage.size.width/2-1,
                                                  self.currentImage.size.height/2,
                                                  self.currentImage.size.width/2);
        self.sui_normalImage = [self.currentImage resizableImageWithCapInsets:curInsets resizingMode:UIImageResizingModeStretch];
    }
}

- (BOOL)sui_resizableBackground
{
    self.sui_resizableBackground = YES;
    return YES;
}
- (void)setSui_resizableBackground:(BOOL)sui_resizableBackground
{
    if (sui_resizableBackground) {
        UIEdgeInsets curInsets = UIEdgeInsetsMake(self.currentBackgroundImage.size.height/2-1,
                                                  self.currentBackgroundImage.size.width/2-1,
                                                  self.currentBackgroundImage.size.height/2,
                                                  self.currentBackgroundImage.size.width/2);
        self.sui_normalBackgroundImage = [self.currentBackgroundImage resizableImageWithCapInsets:curInsets resizingMode:UIImageResizingModeStretch];
    }
}

#pragma mark - hexRgbColor
- (NSString *)sui_titleHexColor
{
    return @"0xffffff";
}

- (void)setSui_titleHexColor:(NSString *)sui_titleHexColor {
    NSScanner *scanner = [NSScanner scannerWithString:sui_titleHexColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    [self setTitleColor:[self sui_colorWithRGBHex:hexNum] forState:UIControlStateNormal];
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

@end
