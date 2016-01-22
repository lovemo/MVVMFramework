//
//  ThirdViewModel.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdViewModel.h"
#import "FirstModel.h"

@implementation ThirdViewModel
- (instancetype)init {
    if (self = [super init]) {
        self.model = [[ThirdModel alloc]init];
        [PMKVObserver observeObject:self keyPath:@"dataArrayList" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id  _Nonnull object, NSDictionary<NSString *,id> * _Nullable change, PMKVObserver * _Nonnull kvo) {
            NSLog(@"新值--%@",change[NSKeyValueChangeNewKey]);
        }];
     
    }
    return self;
}

- (void)getDataListSuccess:(void (^)())success failure:(void (^)())failure {
    // 实际开发中，将url 和 params 换为自己的值，demo测试时为nil即可
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    
    [self getDataList:url params:nil success:^(NSArray *array) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}

- (void)getDataList:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    /**
     *  在这里进行首页控制器的网络请求加载和利用(MJExtension)转换模型
     */
    [BQHttpTool get:url params:nil success:^(id responseObj) {
        NSArray *array = responseObj[@"stories"];
        self.dataArrayList = [ThirdModel mj_objectArrayWithKeyValuesArray:array];
        success(self.dataArrayList);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
- (ThirdModel *)getRandomData {
    u_int32_t index = arc4random_uniform((u_int32_t)self.dataArrayList.count);
    return self.dataArrayList[index];
}
@end
