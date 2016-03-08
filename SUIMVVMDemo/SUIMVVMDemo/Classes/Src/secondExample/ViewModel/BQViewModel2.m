//
//  BQViewModel2.m
//  DevelopFramework
//
//  Created by yuantao on 15/12/25.
//  Copyright © 2015年 momo. All rights reserved.
//

#import "BQViewModel2.h"
#import "BQTestModel.h"
#import "BQGetDataList2.h"

@implementation BQViewModel2


- (NSUInteger)smk_viewModelWithNumberOfItemsInSection:(NSUInteger)section {
    
    return self.smk_dataArrayList.count;
}

- (void)smk_viewModelWithGetDataSuccessHandler:(void (^)())successHandler {
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    
    [BQGetDataList2 get:url param:nil cachePolicy:SMKHttpReturnCacheDataDontLoad modelClass:[BQTestModel class] responseBlock:^(id dataObj, NSError *error) {
        
        if (error) {
            return ;
        }
        self.smk_dataArrayList = dataObj;
        if (successHandler) {
            successHandler();
        }
        
    }];
    
}

@end
