//
//  NSDictionary+SUISafeAccess.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSDictionary+SUISafeAccess.h"
#import "SUIMacro.h"
#import "NSString+SUIAdditions.h"
#import "NSNumber+SUIAdditions.h"

@implementation NSDictionary (SUISafeAccess)


- (id)sui_objectForKey:(id)cKey
{
    id curValue = [self objectForKey:cKey];
    if (!kNilOrNull(curValue)) {
        return curValue;
    }
    return nil;
}

- (NSString *)sui_stringForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        NSString *curString = [NSString sui_stringFromObject:curValue];
        return curString;
    }
    return nil;
}

- (NSNumber *)sui_numberForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSNumber class]]) {
            return curValue;
        }
        if ([curValue isKindOfClass:[NSString class]]) {
            NSNumber *curNumber = ((NSString *)curValue).sui_toNumber;
            return curNumber;
        }
    }
    return nil;
}

- (NSArray *)sui_arrayForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSArray class]]) {
            return curValue;
        }
    }
    return nil;
}

- (NSMutableArray *)sui_mutableArrayForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSMutableArray class]]) {
            return curValue;
        }
    }
    return nil;
}

- (NSDictionary *)sui_dictionaryForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSDictionary class]]) {
            return curValue;
        }
    }
    return nil;
}

- (NSMutableDictionary *)sui_mutableDictionaryForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSMutableDictionary class]]) {
            return curValue;
        }
    }
    return nil;
}

- (NSInteger)sui_integerForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            NSInteger curInteger = [curValue integerValue];
            return curInteger;
        }
    }
    return 0;
}

- (NSUInteger)sui_unsignedIntegerForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            NSUInteger curUInteger = [curValue unsignedIntegerValue];
            return curUInteger;
        }
    }
    return 0;
}

- (BOOL)sui_boolForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            BOOL curRet = [curValue boolValue];
            return curRet;
        }
    }
    return NO;
}

- (float)sui_floatForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            float curFloat = [curValue floatValue];
            return curFloat;
        }
    }
    return 0;
}

- (double)sui_doubleForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            double curDouble = [curValue doubleValue];
            return curDouble;
        }
    }
    return 0;
}

- (CGFloat)sui_CGFloatForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSString class]]) {
            NSNumber *curNumber = ((NSString *)curValue).sui_toNumber;
            CGFloat curFloat = curNumber.sui_CGFloatValue;
            return curFloat;
        } else if ([curValue isKindOfClass:[NSNumber class]]) {
            CGFloat curFloat = ((NSNumber *)curValue).sui_CGFloatValue;
            return curFloat;
        }
    }
    return 0;
}

- (CGPoint)sui_pointForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSString class]]) {
            CGPoint curPoint = CGPointFromString(curValue);
            return curPoint;
        }
    }
    return CGPointZero;
}

- (CGSize)sui_sizeForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSString class]]) {
            CGSize curSize = CGSizeFromString(curValue);
            return curSize;
        }
    }
    return CGSizeZero;
}

- (CGRect)sui_rectForKey:(id)cKey
{
    id curValue = [self sui_objectForKey:cKey];
    if (curValue) {
        if ([curValue isKindOfClass:[NSString class]]) {
            CGRect curRect = CGRectFromString(curValue);
            return curRect;
        }
    }
    return CGRectZero;
}


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NSMutableDictionary
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@implementation NSMutableDictionary (SUISafeAccess)


- (void)sui_setObj:(id)a forKey:(NSString *)cKey
{
    if (a != nil) {
        [self setObject:a forKey:cKey];
    }
}

- (void)sui_setInteger:(NSInteger)a forKey:(NSString *)cKey
{
    [self setObject:@(a) forKey:cKey];
}

- (void)sui_setUnsignedInteger:(NSUInteger)a forKey:(NSString *)cKey
{
    [self setObject:@(a) forKey:cKey];
}

- (void)sui_setBool:(BOOL)a forKey:(NSString *)cKey
{
    [self setObject:@(a) forKey:cKey];
}

- (void)sui_setFloat:(float)a forKey:(NSString *)cKey
{
    [self setObject:@(a) forKey:cKey];
}

- (void)sui_setDouble:(double)a forKey:(NSString *)cKey
{
    [self setObject:@(a) forKey:cKey];
}

- (void)sui_setCGFloat:(CGFloat)a forKey:(NSString *)cKey
{
    [self setObject:@(a) forKey:cKey];
}

- (void)sui_setPoint:(CGPoint)a forKey:(NSString *)cKey
{
    [self setObject:NSStringFromCGPoint(a) forKey:cKey];
}

- (void)sui_setSize:(CGSize)a forKey:(NSString *)cKey
{
    [self setObject:NSStringFromCGSize(a) forKey:cKey];
}

- (void)sui_setRect:(CGRect)a forKey:(NSString *)cKey
{
    [self setObject:NSStringFromCGRect(a) forKey:cKey];
}


@end
