//
//  NSDictionary+SUISafeAccess.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (SUISafeAccess)


- (nullable id)sui_objectForKey:(id)cKey;

- (nullable NSString *)sui_stringForKey:(id)cKey;

- (nullable NSNumber *)sui_numberForKey:(id)cKey;

- (nullable NSArray *)sui_arrayForKey:(id)cKey;

- (nullable NSMutableArray *)sui_mutableArrayForKey:(id)cKey;

- (nullable NSDictionary *)sui_dictionaryForKey:(id)cKey;

- (nullable NSMutableDictionary *)sui_mutableDictionaryForKey:(id)cKey;

- (NSInteger)sui_integerForKey:(id)cKey;

- (NSUInteger)sui_unsignedIntegerForKey:(id)cKey;

- (BOOL)sui_boolForKey:(id)cKey;

- (float)sui_floatForKey:(id)cKey;

- (double)sui_doubleForKey:(id)cKey;

- (CGFloat)sui_CGFloatForKey:(id)cKey;

- (CGPoint)sui_pointForKey:(id)cKey;

- (CGSize)sui_sizeForKey:(id)cKey;

- (CGRect)sui_rectForKey:(id)cKey;


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NSMutableDictionary
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@interface NSMutableDictionary(SUISafeAccess)


- (void)sui_setObj:(id)a forKey:(NSString *)cKey;

- (void)sui_setInteger:(NSInteger)a forKey:(NSString *)cKey;

- (void)sui_setUnsignedInteger:(NSUInteger)a forKey:(NSString *)cKey;

- (void)sui_setBool:(BOOL)a forKey:(NSString *)cKey;

- (void)sui_setFloat:(float)a forKey:(NSString *)cKey;

- (void)sui_setDouble:(double)a forKey:(NSString *)cKey;

- (void)sui_setCGFloat:(CGFloat)a forKey:(NSString *)cKey;

- (void)sui_setPoint:(CGPoint)a forKey:(NSString *)cKey;

- (void)sui_setSize:(CGSize)a forKey:(NSString *)cKey;

- (void)sui_setRect:(CGRect)a forKey:(NSString *)cKey;


@end

NS_ASSUME_NONNULL_END
