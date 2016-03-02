//
//  MVVMHUD.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/2.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "MVVMHUD.h"

@implementation MVVMHUD

+ (void)sui_setBackgroundColor:(UIColor*)color {
    [SVProgressHUD setBackgroundColor:color];
}
+ (void)sui_setForegroundColor:(UIColor*)color {
    [SVProgressHUD setForegroundColor:color];
}
+ (void)sui_setRingThickness:(CGFloat)width {
    [SVProgressHUD setRingThickness:width];
}
+ (void)sui_setFont:(UIFont*)font {
    [SVProgressHUD setFont:font];
}
+ (void)sui_setInfoImage:(UIImage*)image {
    [SVProgressHUD setInfoImage:image];
}
+ (void)sui_setSuccessImage:(UIImage*)image {
    [SVProgressHUD setSuccessImage:image];
}
+ (void)sui_setErrorImage:(UIImage*)image {
    [SVProgressHUD setErrorImage:image];
}
+ (void)sui_setDefaultMaskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD setDefaultMaskType:maskType];
}
+ (void)sui_setViewForExtension:(UIView*)view {
    [SVProgressHUD setViewForExtension:view];
}

#pragma mark - Show Methods

+ (void)sui_show {
    [SVProgressHUD show];
}
+ (void)sui_showWithMaskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showWithMaskType:maskType];
}
+ (void)sui_showWithStatus:(NSString*)status {
    [SVProgressHUD showWithStatus:status];
}
+ (void)sui_showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showWithStatus:status maskType:maskType];
}

+ (void)sui_showProgress:(float)progress {
    [SVProgressHUD showProgress:progress];
}
+ (void)sui_showProgress:(float)progress maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showProgress:progress maskType:maskType];
}
+ (void)sui_showProgress:(float)progress status:(NSString*)status {
    [SVProgressHUD showProgress:progress status:status];
}
+ (void)sui_showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showProgress:progress status:status maskType:maskType];
}

+ (void)sui_setStatus:(NSString*)string {
    [SVProgressHUD setStatus:string];
}
// stops the activity indicator, shows a glyph + status, and dismisses HUD a little bit later
+ (void)sui_showInfoWithStatus:(NSString *)string {
    [SVProgressHUD showInfoWithStatus:string];
}
+ (void)sui_showInfoWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showWithStatus:string maskType:maskType];
}

+ (void)sui_showSuccessWithStatus:(NSString*)string {
    [SVProgressHUD showSuccessWithStatus:string];
}
+ (void)sui_showSuccessWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showSuccessWithStatus:string maskType:maskType];
}

+ (void)sui_showErrorWithStatus:(NSString *)string {
    [SVProgressHUD showErrorWithStatus:string];
}
+ (void)sui_showErrorWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showErrorWithStatus:string maskType:maskType];
}

// use 28x28 white pngs
+ (void)sui_showImage:(UIImage*)image status:(NSString*)status {
    [SVProgressHUD showImage:image status:status];
}
+ (void)sui_showImage:(UIImage*)image status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showImage:image status:status maskType:maskType];
}

+ (void)sui_setOffsetFromCenter:(UIOffset)offset {
    [SVProgressHUD setOffsetFromCenter:offset];
}
+ (void)sui_resetOffsetFromCenter {
    [SVProgressHUD resetOffsetFromCenter];
}

+ (void)sui_popActivity {
    [SVProgressHUD popActivity];
}
+ (void)sui_dismiss {
    [SVProgressHUD dismiss];
}

+ (BOOL)sui_isVisible {
    return [SVProgressHUD isVisible];
}

@end
