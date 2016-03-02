//
//  MVVMHUD.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/2.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVVMHUD : NSObject

#pragma mark - Customization

+ (void)sui_setBackgroundColor:(UIColor*)color;                 // default is [UIColor whiteColor]
+ (void)sui_setForegroundColor:(UIColor*)color;                 // default is [UIColor blackColor]
+ (void)sui_setRingThickness:(CGFloat)width;                    // default is 4 pt
+ (void)sui_setFont:(UIFont*)font;                              // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
+ (void)sui_setInfoImage:(UIImage*)image;                       // default is the bundled info image provided by Freepik
+ (void)sui_setSuccessImage:(UIImage*)image;                    // default is the bundled success image provided by Freepik
+ (void)sui_setErrorImage:(UIImage*)image;                      // default is the bundled error image provided by Freepik
+ (void)sui_setDefaultMaskType:(SVProgressHUDMaskType)maskType; // default is SVProgressHUDMaskTypeNone
+ (void)sui_setViewForExtension:(UIView*)view;                  // default is nil, only used if #define SV_APP_EXTENSIONS is set

#pragma mark - Show Methods

+ (void)sui_show;
+ (void)sui_showWithMaskType:(SVProgressHUDMaskType)maskType;
+ (void)sui_showWithStatus:(NSString*)status;
+ (void)sui_showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

+ (void)sui_showProgress:(float)progress;
+ (void)sui_showProgress:(float)progress maskType:(SVProgressHUDMaskType)maskType;
+ (void)sui_showProgress:(float)progress status:(NSString*)status;
+ (void)sui_showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

+ (void)sui_setStatus:(NSString*)string; // change the HUD loading status while it's showing

// stops the activity indicator, shows a glyph + status, and dismisses HUD a little bit later
+ (void)sui_showInfoWithStatus:(NSString *)string;
+ (void)sui_showInfoWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;

+ (void)sui_showSuccessWithStatus:(NSString*)string;
+ (void)sui_showSuccessWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)maskType;

+ (void)sui_showErrorWithStatus:(NSString *)string;
+ (void)sui_showErrorWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;

// use 28x28 white pngs
+ (void)sui_showImage:(UIImage*)image status:(NSString*)status;
+ (void)sui_showImage:(UIImage*)image status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

+ (void)sui_setOffsetFromCenter:(UIOffset)offset;
+ (void)sui_resetOffsetFromCenter;

+ (void)sui_popActivity; // decrease activity count, if activity count == 0 the HUD is dismissed
+ (void)sui_dismiss;

+ (BOOL)sui_isVisible;

@end
