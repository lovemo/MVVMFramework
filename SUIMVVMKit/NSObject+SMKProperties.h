//
//  NSObject+SMKProperties.h
//  SMKMVVM
//
//  Created by Mac on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SMKProperties)

/**
 *  获取一个对象的所有属性
 */
- (nullable NSDictionary *)smk_allProperties;

@end
