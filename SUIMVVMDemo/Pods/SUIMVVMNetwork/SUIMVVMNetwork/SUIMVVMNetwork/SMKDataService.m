//
//  SMKDataService.m
//  MVVMFramework
//
//  Created by Mac on 16/1/22.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "SMKDataService.h"

static id dataObj;

@implementation SMKDataService

+ (void)get:(NSString *)url param:(id)param cachePolicy:(SMKHttpRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    [SMKHttp get:url params:param cachePolicy:cachePolicy success:^(id responseObj) {
        //数组、字典转化为模型数组
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
        
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)post:(NSString *)url param:(id)param cachePolicy:(SMKHttpRequestCachePolicy)cachePolicy modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [SMKHttp post:url params:param cachePolicy:cachePolicy success:^(id responseObj) {
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)put:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [SMKHttp put:url params:param success:^(id responseObj) {
        
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseDataBlock(dataObj, nil);
    } failure:^(NSError *error) {
        
        responseDataBlock(nil, error);
    }];
}

+ (void)deleteWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseBlock)responseDataBlock {
    
    [SMKHttp deleteWithUrl:url params:param success:^(id responseObj) {
        
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
