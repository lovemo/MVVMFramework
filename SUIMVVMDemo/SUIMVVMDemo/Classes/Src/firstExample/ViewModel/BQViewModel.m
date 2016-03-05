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

- (NSUInteger)smk_viewModelWithNumberOfRowsInSection:(NSUInteger)section {
  
    return self.smk_dataArrayList.count;
}

- (void)smk_viewModelWithGetDataSuccessHandler:(void (^)())successHandler {
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    
    [BQGetDataList get:url param:nil cachePolicy:SMKHttpReturnCacheDataElseLoad modelClass:[FirstModel class] responseBlock:^(id dataObj, NSError *error) {
        
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
