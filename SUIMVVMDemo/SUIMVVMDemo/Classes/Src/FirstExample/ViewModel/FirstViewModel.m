//
//  FirstViewModel.m
//  DevelopFramework
//
//  Created by momo on 15/12/23.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "FirstViewModel.h"
#import "FirstModel.h"
#import "FirstRequest.h"
#import "SMKAction.h"

@interface FirstViewModel ()

@end

@implementation FirstViewModel

- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
//    // 方式1
//    return [[SMKAction sharedAction] sendRequest:[[FirstRequest alloc]init] progress:nil success:^(id responseObject) {
//        if (responseObject) {
//            NSArray *modelArray = [FirstModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
//            success(modelArray);
//        }
//    } failure:nil];
    
    
    return [[SMKAction sharedAction] sendRequestBlock:^(NSObject *request) {
        
//        // 方式2
//        return [[FirstRequest alloc]init];
        
        // 方式3
        //smk_url (如果设置了url，则不需要在设置scheme，host，path 属性)
        request.smk_scheme = @"https";
        request.smk_host = @"api.douban.com";
        request.smk_path = @"/v2/book/search";
        request.smk_method = SMKRequestMethodGET;     // default
        request.smk_params = @{@"q": @"基础"};
        
        return request;
        
    } progress:nil success:^(id responseObject) {
        if (responseObject) {
            NSArray *modelArray = [FirstModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
            success(modelArray);
        }
    } failure:nil];
    
}

@end
