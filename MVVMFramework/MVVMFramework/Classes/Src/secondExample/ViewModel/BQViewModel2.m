//
//  BQViewModel2.m
//  DevelopFramework
//
//  Created by yuantao on 15/12/25.
//  Copyright © 2015年 momo. All rights reserved.
//

#import "BQBaseViewModel.h"
#import "BQViewModel2.h"
#import "BQTestModel.h"
#import "SVProgressHUD.h"
#import "BQGetDataList2.h"

@implementation BQViewModel2


- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    
    return self.dataArrayList.count;
}

//- (instancetype)modelAtIndexPath:(NSIndexPath *)indexPath {
//    NSObject *obj = self.dataArrayList[indexPath.row];
//    BQModel *model = (BQModel *)obj;
//    return model;
//}

- (void)getDataListSuccess:(void (^)())success {
    // 实际开发中，将url 和 params 换为自己的值，demo测试时为nil即可
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    
    [self getDataList:url params:nil success:^(NSArray *array) {
        if (success) {
            success();
        }
    } failure:nil];
}

- (void)getDataList:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    [BQGetDataList2 getWithUrl:url param:nil cachePolicy:BQHttpToolReturnCacheDataDontLoad modelClass:[BQTestModel class] responseBlock:^(id dataObj, NSError *error) {
        
        if (error) {
            failure(error);
            success(nil);
            return ;
        }
        self.dataArrayList = dataObj;
        success(self.dataArrayList);
        
    }];
    
}

@end
