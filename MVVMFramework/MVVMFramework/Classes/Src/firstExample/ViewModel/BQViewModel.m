//
//  BQViewModel.m
//  DevelopFramework
//
//  Created by momo on 15/12/23.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQViewModel.h"
#import "FirstModel.h"
#import "BQTestModel.h"


@interface BQViewModel ()

@end

@implementation BQViewModel

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
  
    return self.dataArrayList.count;
}

//- (instancetype)modelAtIndexPath:(NSIndexPath *)indexPath {
//    NSObject *obj = self.dataArrayList[indexPath.row];
//    BQModel *model = (BQModel *)obj;
//    return model;
//}

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
    [BQHttpTool get:url params:nil cachePolicy:BQHttpToolReturnCacheDataElseLoad success:^(id json) {
        NSArray *array = json[@"stories"];
    
        self.dataArrayList = [FirstModel mj_objectArrayWithKeyValuesArray:array];
        for (FirstModel *m in self.dataArrayList) {
            [PMKVObserver observeObject:m keyPath:@"title" options:0 block:^(id  _Nonnull object, NSDictionary<NSString *,id> * _Nullable change, PMKVObserver * _Nonnull kvo) {
                NSString *old = change[NSKeyValueChangeOldKey];
                NSString *new = change[NSKeyValueChangeNewKey];
                NSLog(@"%@------%@",old,new);
            }];
        }
        success(self.dataArrayList);
        NSLog(@"%@",PATH_OF_CACHES);

    } failure:^(NSError *error) {
        failure(error);
    }];

}

@end
