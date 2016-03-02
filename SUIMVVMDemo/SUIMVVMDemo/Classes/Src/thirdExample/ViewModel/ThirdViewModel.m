//
//  ThirdViewModel.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewModel.h"
#import "ThirdModel.h"
#import <MVVMNetworkPublic.h>

@implementation ThirdViewModel

- (void)vm_getDataSuccessHandler:(void (^)())successHandler {
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    [MVVMHttp get:url params:nil cachePolicy:MVVMHttpReturnCacheDataThenLoad success:^(id responseObj) {
        
        NSArray *array = responseObj[@"stories"];
        self.dataArrayList = [ThirdModel mj_objectArrayWithKeyValuesArray:array];
        if (successHandler) {
            successHandler();
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (instancetype)getRandomData {
    if (self.dataArrayList.count > 0) {
        u_int32_t index = arc4random_uniform((u_int32_t)self.dataArrayList.count);
        return self.dataArrayList[index];
    }
    return nil;
}
@end
