//
//  BQViewModel2.m
//  DevelopFramework
//
//  Created by yuantao on 15/12/25.
//  Copyright © 2015年 momo. All rights reserved.
//

#import "MVVMBaseViewModel.h"
#import "BQViewModel2.h"
#import "BQTestModel.h"
#import "SVProgressHUD.h"
#import "BQGetDataList2.h"

@implementation BQViewModel2


- (NSUInteger)vm_numberOfItemsInSection:(NSUInteger)section {
    
    return self.dataArrayList.count;
}

//- (instancetype)modelAtIndexPath:(NSIndexPath *)indexPath {
//    NSObject *obj = self.dataArrayList[indexPath.row];
//    BQModel *model = (BQModel *)obj;
//    return model;
//}

- (void)vm_getDataSuccessHandler:(void (^)())successHandler {
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    
    [BQGetDataList2 getWithUrl:url param:nil cachePolicy:MVVMHttpReturnCacheDataDontLoad modelClass:[BQTestModel class] responseBlock:^(id dataObj, NSError *error) {
        
        if (error) {
            return ;
        }
        self.dataArrayList = dataObj;
        if (successHandler) {
            successHandler();
        }
        
    }];
    
}

@end
