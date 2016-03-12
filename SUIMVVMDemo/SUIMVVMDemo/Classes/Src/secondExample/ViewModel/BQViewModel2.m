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


- (void)smk_viewModelWithGetDataSuccessHandler:(void (^)(NSArray *))successHandler {
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    
    [BQGetDataList2 get:url param:nil cachePolicy:SMKHttpReturnDefault modelClass:[BQTestModel class] responseBlock:^(id dataObj, NSError *error) {
        
        if (successHandler) {
            successHandler(dataObj);
        }
        
    }];
    
}

@end
