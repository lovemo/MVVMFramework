//
//  BQDataService.h
//  MVVMFramework
//
//  Created by Mac on 16/1/22.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BQHttpTool;
@interface BQDataService : NSObject

/**
 GET请求转模型
 */
+ (void)getWithUrl:(NSString *)url param:(id)param cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;

/**
 POST请求转模型
 */
+ (void)postWithUrl:(NSString *)url param:(id)param cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;


+ (void)putWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;

+ (void)deleteWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock;

/**
 数组、字典转模型，提供给子类的接口
 */
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass;


@end
