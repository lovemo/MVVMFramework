//
//  MVVMBaseViewManger.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/22.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMViewMangerProtocol.h"

@interface MVVMBaseViewManger : NSObject <MVVMViewMangerProtocol>

/** 用于传递数据的基模型 */
@property (nonatomic, strong) NSObject *sui_model;

@end
