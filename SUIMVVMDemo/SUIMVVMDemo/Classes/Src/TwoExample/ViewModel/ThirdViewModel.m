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

#pragma mark 加载网络请求
- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    return [[SMKAction sharedAction] sendRequestBlock:^id(NSObject *request) {
        return [[ThirdRequest alloc]init];
    } progress:nil success:^(id responseObject) {
        NSArray *modelArray = [ThirdModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
        if (success) {
            success(modelArray);
        }
    } failure:nil];
    
}

- (id)getRandomData:(NSArray *)array {
    u_int32_t index = arc4random_uniform((u_int32_t)10);
    return array[index];
}

#pragma mark 配置加工模型数据，并通过block传递给view
- (void)smk_viewModelWithModelBlcok:(void (^)(id))modelBlock {
    [self smk_viewModelWithProgress:nil success:^(id responseObject) {
        if (modelBlock) {
            
            if (self.viewModelDelegate && [self.viewModelDelegate respondsToSelector:@selector(smk_viewModel:withInfos:)]) {
                [self.viewModelDelegate smk_viewModel:self withInfos:@{@"info" : @"呵呵， 你好， 我是ViewModel，我加载数据成功了"}];
            }
            
            modelBlock([self getRandomData:responseObject]);
        }
    } failure:nil];

}

#pragma mark ViewManger delegate
- (void)smk_viewManger:(id)viewManger withInfos:(NSDictionary *)infos  {
    NSLog(@"%@",infos);
}

#pragma mark ViewManger Block
- (ViewMangerInfosBlock)smk_viewModelWithViewMangerBlockOfInfos:(NSDictionary *)infos {
    return ^{
      NSLog(@"hello");
    };
}

@end
