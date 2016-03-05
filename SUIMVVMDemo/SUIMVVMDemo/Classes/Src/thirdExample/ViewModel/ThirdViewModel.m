//
//  ThirdViewModel.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewModel.h"
#import "ThirdModel.h"
#import "SMKNetworkPublic.h"

@implementation ThirdViewModel

- (void)smk_viewModelWithGetDataSuccessHandler:(void (^)())successHandler {
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    [SMKHttp get:url params:nil cachePolicy:SMKHttpReturnCacheDataThenLoad success:^(id responseObj) {
        
        NSArray *array = responseObj[@"stories"];
        self.smk_dataArrayList = [ThirdModel mj_objectArrayWithKeyValuesArray:array];
        if (successHandler) {
            successHandler();
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (instancetype)getRandomData {
    if (self.smk_dataArrayList.count > 0) {
        u_int32_t index = arc4random_uniform((u_int32_t)self.smk_dataArrayList.count);
        return self.smk_dataArrayList[index];
    }
    return nil;
}
@end
