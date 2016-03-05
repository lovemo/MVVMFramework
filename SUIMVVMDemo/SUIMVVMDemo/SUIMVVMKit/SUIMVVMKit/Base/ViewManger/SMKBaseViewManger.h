//
//  SMKBaseViewManger.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/22.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKViewMangerProtocolDelegate.h"

@interface SMKBaseViewManger : NSObject <SMKViewMangerProtocolDelegate>

/**
 *  用于传递数据的基模型
 */
@property (nonatomic, strong) NSObject *smk_model;

@end
