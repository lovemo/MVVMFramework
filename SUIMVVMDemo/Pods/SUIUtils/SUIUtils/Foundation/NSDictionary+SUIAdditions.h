//
//  NSDictionary+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Prehash
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Prehash

@property (nullable,readonly,copy) NSString *sui_toString;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Operate
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Operate

- (BOOL)sui_hasKey:(id)cKey;

- (void)sui_each:(void (^)(KeyType key, ObjectType obj))cb;

- (void)sui_eachWithStop:(BOOL (^)(KeyType key, ObjectType obj))cb;

- (instancetype)sui_map:(id (^)(KeyType key, ObjectType obj))cb;

- (instancetype)sui_pick:(NSArray *)cKeys;

- (instancetype)sui_Omit:(NSArray *)cKeys;

- (instancetype)sui_merge:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
