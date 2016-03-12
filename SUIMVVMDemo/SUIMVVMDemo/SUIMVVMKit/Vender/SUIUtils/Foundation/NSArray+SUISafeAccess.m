//
//  NSArray+SUISafeAccess.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSArray+SUISafeAccess.h"
#import "SUIMacro.h"
#import "NSString+SUIAdditions.h"
#import "NSNumber+SUIAdditions.h"

@implementation NSArray (SUISafeAccess)


- (id)sui_objectWithIndex:(NSUInteger)cIndex
{
    if (cIndex < self.count) {
        return self[cIndex];
    }
    return nil;
}

- (NSString *)sui_stringWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        NSString *curString = [NSString sui_stringFromObject:curValue];
        return curString;
    }
    return nil;
}

- (NSNumber *)sui_numberWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
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

- (NSArray *)sui_arrayWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSArray class]]) {
            return curValue;
        }
    }
    return nil;
}

- (NSMutableArray *)sui_mutableArrayWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSMutableArray class]]) {
            return curValue;
        }
    }
    return nil;
}

- (NSDictionary *)sui_dictionaryWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSDictionary class]]) {
            return curValue;
        }
    }
    return nil;
}

- (NSMutableDictionary *)sui_mutableDictionaryWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSMutableDictionary class]]) {
            return curValue;
        }
    }
    return nil;
}

- (NSInteger)sui_integerWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            NSInteger curInteger = [curValue integerValue];
            return curInteger;
        }
    }
    return 0;
}

- (NSUInteger)sui_unsignedIntegerWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            NSUInteger curUInteger = [curValue unsignedIntegerValue];
            return curUInteger;
        }
    }
    return 0;
}

- (BOOL)sui_boolWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            BOOL curRet = [curValue boolValue];
            return curRet;
        }
    }
    return NO;
}

- (float)sui_floatWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            float curFloat = [curValue floatValue];
            return curFloat;
        }
    }
    return 0;
}

- (double)sui_doubleWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]] ||
            [curValue isKindOfClass:[NSNumber class]]) {
            double curDouble = [curValue doubleValue];
            return curDouble;
        }
    }
    return 0;
}

- (CGFloat)sui_CGFloatWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
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

- (CGPoint)sui_pointWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]]) {
            CGPoint curPoint = CGPointFromString(curValue);
            return curPoint;
        }
    }
    return CGPointZero;
}

- (CGSize)sui_sizeWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]]) {
            CGSize curSize = CGSizeFromString(curValue);
            return curSize;
        }
    }
    return CGSizeZero;
}

- (CGRect)sui_rectWithIndex:(NSUInteger)cIndex
{
    id curValue = [self sui_objectWithIndex:cIndex];
    if (!kNilOrNull(curValue)) {
        if ([curValue isKindOfClass:[NSString class]]) {
            CGRect curRect = CGRectFromString(curValue);
            return curRect;
        }
    }
    return CGRectZero;
}


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NSMutableArray
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@implementation NSMutableArray (SUISafeAccess)


- (void)sui_addObj:(id)a
{
    if (a != nil) {
        [self addObject:a];
    }
}

- (void)sui_addInteger:(NSInteger)a
{
    [self addObject:@(a)];
}

- (void)sui_addUnsignedInteger:(NSUInteger)a
{
    [self addObject:@(a)];
}

- (void)sui_addBool:(BOOL)a
{
    [self addObject:@(a)];
}

- (void)sui_addFloat:(float)a
{
    [self addObject:@(a)];
}

- (void)sui_addDouble:(double)a
{
    [self addObject:@(a)];
}

- (void)sui_addCGFloat:(CGFloat)a
{
    [self addObject:@(a)];
}

- (void)sui_addPoint:(CGPoint)a
{
    [self addObject:NSStringFromCGPoint(a)];
}

- (void)sui_addSize:(CGSize)a
{
    [self addObject:NSStringFromCGSize(a)];
}

- (void)sui_addRect:(CGRect)a
{
    [self addObject:NSStringFromCGRect(a)];
}


@end
