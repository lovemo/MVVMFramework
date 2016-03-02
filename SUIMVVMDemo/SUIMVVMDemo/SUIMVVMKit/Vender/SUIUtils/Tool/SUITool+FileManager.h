//
//  SUITool+FileManager.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "SUITool.h"

NS_ASSUME_NONNULL_BEGIN

@interface SUITool (FileManager)


+ (BOOL)fileCreateDirectory:(NSString *)filePath;

+ (BOOL)fileExist:(NSString *)filePath;

+ (BOOL)fileWrite:(NSData *)data toPath:(NSString *)filePath;

+ (BOOL)fileMove:(NSString *)sourcePath toPath:(NSString *)filePath;

+ (BOOL)fileCopy:(NSString *)sourcePath toPath:(NSString *)filePath;

+ (nullable NSData *)fileRead:(NSString *)filePath;

+ (NSUInteger)fileSize:(NSString *)filePath;

+ (BOOL)fileDelete:(NSString *)filePath;


@end

NS_ASSUME_NONNULL_END
