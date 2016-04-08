//
//  ThirdViewModel.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewModel.h"
#import "ThirdModel.h"
#import "ThirdRequest.h"
#import "SMKAction.h"

@interface ThirdViewModel ()

@end

@implementation ThirdViewModel

- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    return [[SMKAction sharedAction] sendRequestBlock:^id<SMKRequestProtocol>{
        return [[ThirdRequest alloc]init];
    } progress:nil success:^(id responseObject) {
        NSArray *modelArray = [ThirdModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
        if (success) {
            success(modelArray);
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (id)getRandomData:(NSArray *)array {
    u_int32_t index = arc4random_uniform((u_int32_t)10);
    return array[index];
}
@end
