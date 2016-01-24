//
//  BQViewModel.h
//  DevelopFramework
//
//  Created by momo on 15/12/23.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  请求成功block
 */
typedef void (^requestSuccessBlock)(id responseObj);

/**
 *  请求失败block
 */
typedef void (^requestFailureBlock) (NSError *error);

/**
 *  请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);

/**
 *  监听进度响应block
 */
typedef void (^progressBlock)(NSProgress * progress);


typedef NS_ENUM(NSUInteger, BQHttpToolRequestCachePolicy){
    /** 有缓存就先返回缓存，同步请求数据 */
    BQHttpToolReturnCacheDataThenLoad = 0,
     /** 忽略缓存，重新请求 */
    BQHttpToolReloadIgnoringLocalCacheData,
    /** 有缓存就用缓存，没有缓存就重新请求(用于数据不变时) */
    BQHttpToolReturnCacheDataElseLoad,
    /** 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）*/
    BQHttpToolReturnCacheDataDontLoad
};

#pragma mark - 定义请求工具类

@class BQFileConfig;

@interface BQHttpTool : NSObject

/**
 *  请求超时时间
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  创建单例对象
 */
+ (BQHttpTool *)defaultHttpTool;

/**
 *  移除所有缓存
 */
+ (void)removeAllCaches;

/**
 *  GET请求 - 默认 BQHttpToolReturnCacheDataThenLoad 的缓存方式
 */
+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler;

/**
 *  POST请求 - 默认 BQHttpToolReturnCacheDataThenLoad 的缓存方式
 */
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(requestSuccessBlock)successHandler
     failure:(requestFailureBlock)failureHandler;

/**
 *  GET请求
 */
+ (void)get:(NSString *)url
     params:(NSDictionary *)params
cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler;

/**
 *  POST请求
 */
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy
     success:(requestSuccessBlock)successHandler
     failure:(requestFailureBlock)failureHandler;

/**
 *  PUT请求
 */
+ (void)put:(NSString *)url
    params:(NSDictionary *)params
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler;

/**
 *  DELETE请求
 */
+ (void)delete:(NSString *)url
    params:(NSDictionary *)params
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler;

/**
 *  下载文件，监听下载进度
 */
+ (void)download:(NSString *)url
    successAndProgress:(progressBlock)progressHandler
    complete:(responseBlock)completionHandler;

/**
 *  文件上传
 */
+ (void)upload:(NSString *)url
    params:(NSDictionary *)params fileConfig:(BQFileConfig *)fileConfig
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler;

/**
 *   文件上传，监听上传进度
 */
+ (void)upload:(NSString *)url
        params:(NSDictionary *)params
    fileConfig:(BQFileConfig *)fileConfig
successAndProgress:(progressBlock)progressHandler
      complete:(responseBlock)completionHandler;

@end


/**
 *  用来封装上文件数据的模型类
 */
@interface BQFileConfig : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *fileData;

/**
 *  服务器接收参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

+ (instancetype)fileConfigWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

- (instancetype)initWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end
