//
//  SUITool+OpenURL.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "SUITool.h"

NS_ASSUME_NONNULL_BEGIN

@interface SUITool (OpenURL)


+ (BOOL)openMail:(NSString *)mail;

+ (BOOL)openPhone:(NSString *)phone;

+ (BOOL)openAppStore:(NSString *)appId;


@end

NS_ASSUME_NONNULL_END
