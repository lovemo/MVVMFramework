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
    
    return [[SMKAction sharedAction] sendRequestBlock:^id<SMKRequestProtocol>{
        return [[FirstRequest alloc]init];
    } progress:nil success:^(id responseObject) {
        if (responseObject) {
            NSArray *modelArray = [FirstModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
            success(modelArray);
        }
    } failure:^(NSError *error) {
        
    }];

}

@end
