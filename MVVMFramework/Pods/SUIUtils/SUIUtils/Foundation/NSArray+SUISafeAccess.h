//
//  NSArray+SUISafeAccess.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SUISafeAccess)


- (nullable id)sui_objectWithIndex:(NSUInteger)cIndex;

- (nullable NSString *)sui_stringWithIndex:(NSUInteger)cIndex;

- (nullable NSNumber *)sui_numberWithIndex:(NSUInteger)cIndex;

- (nullable NSArray *)sui_arrayWithIndex:(NSUInteger)cIndex;

- (nullable NSMutableArray *)sui_mutableArrayWithIndex:(NSUInteger)cIndex;

- (nullable NSDictionary *)sui_dictionaryWithIndex:(NSUInteger)cIndex;

- (nullable NSMutableDictionary *)sui_mutableDictionaryWithIndex:(NSUInteger)cIndex;

- (NSInteger)sui_integerWithIndex:(NSUInteger)cIndex;

- (NSUInteger)sui_unsignedIntegerWithIndex:(NSUInteger)cIndex;

- (BOOL)sui_boolWithIndex:(NSUInteger)cIndex;

- (float)sui_floatWithIndex:(NSUInteger)cIndex;

- (double)sui_doubleWithIndex:(NSUInteger)cIndex;

- (CGFloat)sui_CGFloatWithIndex:(NSUInteger)cIndex;

- (CGPoint)sui_pointWithIndex:(NSUInteger)cIndex;

- (CGSize)sui_sizeWithIndex:(NSUInteger)cIndex;

- (CGRect)sui_rectWithIndex:(NSUInteger)cIndex;


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NSMutableArray
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@interface NSMutableArray (SUISafeAccess)


- (void)sui_addObj:(id)a;

- (void)sui_addInteger:(NSInteger)a;

- (void)sui_addUnsignedInteger:(NSUInteger)a;

- (void)sui_addBool:(BOOL)a;

- (void)sui_addFloat:(float)a;

- (void)sui_addDouble:(double)a;

- (void)sui_addCGFloat:(CGFloat)a;

- (void)sui_addPoint:(CGPoint)a;

- (void)sui_addSize:(CGSize)a;

- (void)sui_addRect:(CGRect)a;


@end

NS_ASSUME_NONNULL_END
