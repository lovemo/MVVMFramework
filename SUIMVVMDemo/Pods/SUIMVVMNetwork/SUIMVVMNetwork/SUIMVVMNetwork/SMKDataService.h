//
//  SMKDataService.h
//  MVVMFramework
//
//  Created by Mac on 16/1/22.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKHttp.h"

@interface SMKDataService : NSObject

/**
 GET请求转模型
 */
+ (void)get:(NSString *)url param:(id)param cachePolicy:(SMKHttpRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;

/**
 POST请求转模型
 */
+ (void)post:(NSString *)url param:(id)param cachePolicy:(SMKHttpRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;


+ (void)put:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;

+ (void)deleteWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;

/**
 数组、字典转模型，提供给子类的接口
 */
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass;


@end
