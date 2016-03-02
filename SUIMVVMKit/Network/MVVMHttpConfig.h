//
//  MVVMHttpConfig.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/2.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMSingleton.h"

@interface MVVMHttpConfig : NSObject

MVVMSingletonH(Config)

/**
 *  网络是否连通
 */
@property(nonatomic, assign, readonly, getter=isReachable) BOOL reachable;

@end
