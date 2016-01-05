//
//  BQViewModel.h
//  DevelopFramework
//
//  Created by momo on 15/12/23.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BQHttpToolRequestCachePolicy){
    BQHttpToolReturnCacheDataThenLoad = 0,  /** 有缓存就先返回缓存，同步请求数据 */
    BQHttpToolReloadIgnoringLocalCacheData,  /** 忽略缓存，重新请求 */
    BQHttpToolReturnCacheDataElseLoad,        /** 有缓存就用缓存，没有缓存就重新请求(用于数据不变时) */
    BQHttpToolReturnCacheDataDontLoad       /** 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）*/
};

@interface BQHttpTool : NSObject

/**
 *  创建单例对象
 */
+ (BQHttpTool *)defaultHttpTool;
/**
 *  移除所有缓存
 */
+ (void)removeAllCaches;
/**
 *  根据指定key移除缓存
 */
+ (void)removeCachesForKey:(NSString *)key;

/**
 *  默认 BQHttpToolReturnCacheDataThenLoad 的缓存方式
 */
+ (void)get:(NSString *)url
                params:(NSDictionary *)params
                success:(void (^)(id json))success
                failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url
                params:(NSDictionary *)params
                success:(void (^)(id json))success
                failure:(void (^)(NSError *error))failure;

+ (void)get:(NSString *)url
                params:(NSDictionary *)params
                cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy
                success:(void (^)(id json))success
                failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url
                params:(NSDictionary *)params
                cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy
                success:(void (^)(id json))success
                failure:(void (^)(NSError *error))failure;

@end
