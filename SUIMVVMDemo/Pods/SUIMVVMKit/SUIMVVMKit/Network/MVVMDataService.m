//
//  BQDataService.m
//  MVVMFramework
//
//  Created by Mac on 16/1/22.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "MVVMDataService.h"

static id dataObj;

@implementation MVVMDataService

+ (void)getWithUrl:(NSString *)url param:(id)param cachePolicy:(MVVMHttpRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    [MVVMHttp get:url params:param cachePolicy:cachePolicy success:^(id responseObj) {
        //数组、字典转化为模型数组
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
        
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param cachePolicy:(MVVMHttpRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [MVVMHttp post:url params:param cachePolicy:cachePolicy success:^(id responseObj) {
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)putWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [MVVMHttp put:url params:param success:^(id responseObj) {
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)deleteWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [MVVMHttp delete:url params:param success:^(id responseObj) {
        
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
