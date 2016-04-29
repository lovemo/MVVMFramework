//
//  NSObject+SMKCoding.m
//  SMKMVVM
//
//  Created by yuantao on 16/4/29.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "NSObject+SMKCoding.h"
#import <objc/runtime.h>

@implementation NSObject (SMKCoding)

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
      [self setWithCoder:aDecoder];
    return self;
}
#pragma clang diagnostic pop

- (void)encodeWithCoder:(NSCoder *)aCoder {
    for (NSString *key in [self getProperties]) {
        id object = [self valueForKey:key];
        if (object) [aCoder encodeObject:object forKey:key];
    }
}

- (void)setWithCoder:(NSCoder *)aDecoder {
    for (NSString *key in [self getProperties]) {
        id value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
}

- (NSDictionary *)getPropertiesDict {

    Class class = [self class];
    unsigned int propertyCount;
    __autoreleasing NSMutableDictionary *propertiesDict = [NSMutableDictionary dictionary];
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);

    NSArray *allowedCodingPropertyNames = [class smk_allowedCodingPropertyNames];
    NSArray *ignoredCodingPropertyNames = [class smk_ignoredCodingPropertyNames];
    
    void(^setValueBlock)(NSString *key, NSMutableDictionary *propertiesDict) = ^(NSString *key, NSMutableDictionary *propertiesDict) {
        if (![ignoredCodingPropertyNames containsObject:key]) {
            id value = [self valueForKey:key];
            value = value ? value : [NSNull null];
            [propertiesDict setValue:value forKey:key];
        }
    };
    
    if (allowedCodingPropertyNames.count) {
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            __autoreleasing NSString *key = @(propertyName);
            
            if ([allowedCodingPropertyNames containsObject:key]) {
                setValueBlock(key, propertiesDict);
            }
        }
        
        free(properties);
        return propertiesDict;
    }
    
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        __autoreleasing NSString *key = @(propertyName);
        setValueBlock(key, propertiesDict);
   
    }
    
    free(properties);
    return propertiesDict;
}

- (NSDictionary *)getProperties
{
    __autoreleasing NSDictionary *propertiesDict = objc_getAssociatedObject([self class], _cmd);
    if (!propertiesDict) {
        propertiesDict = [NSMutableDictionary dictionary];
        Class subclass = [self class];
        while (subclass != [NSObject class])
        {
            [(NSMutableDictionary *)propertiesDict addEntriesFromDictionary:[self getPropertiesDict]];
            subclass = [subclass superclass];
        }
        propertiesDict = [NSDictionary dictionaryWithDictionary:propertiesDict];
        objc_setAssociatedObject([self class], _cmd, propertiesDict, OBJC_ASSOCIATION_RETAIN);
    }
    return propertiesDict;
}

- (BOOL)smk_writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data writeToFile:path atomically:useAuxiliaryFile];
}

+ (instancetype)smk_objectWithFile:(NSString *)path {

    NSData *data = [NSData dataWithContentsOfFile:path];

    id object = nil;
    if (data) {
        NSPropertyListFormat format;
        object = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:NULL];
        
        if (object) {
            if ([object respondsToSelector:@selector(objectForKey:)] && [(NSDictionary *)object objectForKey:@"$archiver"]) {
                object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        } else {
            object = data;
        }
    }
    
    return object;
}

@end
