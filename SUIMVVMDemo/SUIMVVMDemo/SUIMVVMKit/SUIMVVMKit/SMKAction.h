//
//  SMKAction.h
//  SMKMVVM
//
//  Created by yuantao on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKRequestProtocol.h"

/**
 *  请求成功block
 */
typedef void (^successBlock)(id responseObject);
/**
 *  请求失败block
 */
typedef void (^failureBlock) (NSError *error);
/**
 *  请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);
/**
 *  监听进度响应block
 */
typedef void (^progressBlock)(NSProgress * progress);



@class SMKActionFileConfig;
@interface SMKAction : NSObject

/**
 *  请求超时时间
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/**
 reachable
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;
/**
 reachableViaWWAN
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;
/**
 reachableViaWiFi
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;


/**
 *  单例
 */
+ (instancetype)sharedAction;

/**
 *  取消所有操作
 */
- (void)cancelAllOperations;

/**
 *  发送请求(在外部配置request)
 */
- (NSURLSessionTask *)sendRequest:
                        (id<SMKRequestProtocol>)request
                         progress:(progressBlock)progress
                          success:(successBlock)success
                          failure:(failureBlock)failure;

/**
 *  发送请求Block(在block内部配置request)
 */
- (NSURLSessionTask *)sendRequestBlock:
                            (id<SMKRequestProtocol> (^)())requestBlock
                              progress:(progressBlock)progress
                               success:(successBlock)success
                               failure:(failureBlock)failure;



@end


/**
 *  用来封装上文件数据的模型类
 */
@interface SMKRequestFileConfig : NSObject

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



