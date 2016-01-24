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
#import "BQGetDataList.h"

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
    
    [BQGetDataList getWithUrl:url param:nil cachePolicy:BQHttpToolReturnCacheDataElseLoad modelClass:[FirstModel class] responseBlock:^(id dataObj, NSError *error) {
        
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
