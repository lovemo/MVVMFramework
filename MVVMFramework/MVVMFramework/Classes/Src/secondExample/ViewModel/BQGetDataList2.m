//
//  BQGetDataList2.m
//  MVVMFramework
//
//  Created by Mac on 16/1/22.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "BQGetDataList2.h"

@implementation BQGetDataList2

+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
    
    NSArray *array = responseObj[@"stories"];
    
    [modelClass mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
    return [modelClass mj_objectArrayWithKeyValuesArray:array];
}

@end
