//
//  SUITool.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SUILaunchedType) {
    SUILaunchedLatestVersion = 0,
    SUILaunchedFirstLaunched = 1,
    SUILaunchedUpdateVersion = 2
};

@interface SUITool : NSObject


+ (SUILaunchedType)launchedType;

+ (nullable NSString *)previousVersion;


@end

NS_ASSUME_NONNULL_END
