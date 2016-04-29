//
//  NSObject+SMKCoding.h
//  SMKMVVM
//
//  Created by yuantao on 16/4/29.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  SMKCodingProtocol个性化设置archiver协议
 */
@protocol SMKCodingProtocol <NSObject>

@optional

/**
 *  这个数组中的属性名才会进行归档
 */
+ (NSArray *)smk_allowedCodingPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行归档
 */
+ (NSArray *)smk_ignoredCodingPropertyNames;

@end


@interface NSObject (SMKCoding) <SMKCodingProtocol>

/**
 *  archiver
 */
- (BOOL)smk_writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;

/**
 *  unarchiver
 */
+ (instancetype)smk_objectWithFile:(NSString *)path;

@end
