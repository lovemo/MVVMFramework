//
//  NSObject+SMKProperties.m
//  SMKMVVM
//
//  Created by Mac on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "NSObject+SMKProperties.h"
#import <objc/runtime.h>

@implementation NSObject (SMKProperties)

- (nullable NSDictionary *)smk_allProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for (NSUInteger i = 0; i < count; i ++) {

        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [self valueForKey:name];
        
        if (propertyValue) {
            resultDict[name] = propertyValue;
        } else {
            resultDict[name] = @"字典的key对应的value不能为nil";
        }
    }

    free(properties);
    
    return resultDict;
}

@end
