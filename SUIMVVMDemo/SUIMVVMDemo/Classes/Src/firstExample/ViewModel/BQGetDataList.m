//
//  BQGetDataList.m
//  MVVMFramework
//
//  Created by Mac on 16/1/22.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "BQGetDataList.h"
#import "SMKStorePublic.h"

@implementation BQGetDataList

// 重写父类方法
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
    
    NSArray *array = responseObj[@"stories"];
    
    static NSString *tableName = @"arrarList";
    
    SMKStore *store = [SMKStore sharedStore];
    [store db_initWithDBName:@"demo.sqlite" tableName:tableName];
    [store db_putObject:array withId:@"arrayID" intoTable:tableName];

    return [modelClass mj_objectArrayWithKeyValuesArray:array];
    
}

@end
