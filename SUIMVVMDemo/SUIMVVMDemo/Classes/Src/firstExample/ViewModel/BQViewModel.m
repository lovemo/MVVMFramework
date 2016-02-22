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

- (NSUInteger)vm_numberOfRowsInSection:(NSUInteger)section {
  
    return self.dataArrayList.count;
}

//- (instancetype)modelAtIndexPath:(NSIndexPath *)indexPath {
//    NSObject *obj = self.dataArrayList[indexPath.row];
//    BQModel *model = (BQModel *)obj;
//    return model;
//}

- (void)vm_getDataSuccessHandler:(void (^)())successHandler {
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    
    [BQGetDataList getWithUrl:url param:nil cachePolicy:MVVMHttpReturnCacheDataElseLoad modelClass:[FirstModel class] responseBlock:^(id dataObj, NSError *error) {
        
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
