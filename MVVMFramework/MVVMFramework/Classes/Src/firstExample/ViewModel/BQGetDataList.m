//
//  BQGetDataList.m
//  MVVMFramework
//
//  Created by Mac on 16/1/22.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "BQGetDataList.h"

@implementation BQGetDataList

// 重写父类方法
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
    
    NSArray *array = responseObj[@"stories"];
    
    return [modelClass mj_objectArrayWithKeyValuesArray:array];
    
}

@end
