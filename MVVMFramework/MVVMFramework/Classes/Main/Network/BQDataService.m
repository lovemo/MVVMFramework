//
//  BQDataService.m
//  MVVMFramework
//
//  Created by Mac on 16/1/22.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "BQDataService.h"
#import "BQHttpTool.h"

static id dataObj;

@implementation BQDataService

+ (void)getWithUrl:(NSString *)url param:(id)param cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    [BQHttpTool get:url params:param cachePolicy:cachePolicy success:^(id responseObj) {
        //数组、字典转化为模型数组
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
        
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [BQHttpTool post:url params:param cachePolicy:cachePolicy success:^(id responseObj) {
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)putWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [BQHttpTool put:url params:param success:^(id responseObj) {
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)deleteWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [BQHttpTool delete:url params:param success:^(id responseObj) {
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

/**
 数组、字典转化为模型
 */
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
    
    return nil;
}

@end
