//
//  SMKRequestProtocol.h
//  SMKMVVM
//
//  Created by yuantao on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMKRequestProtocol <NSObject>

@optional

/**
 *  配置request请求参数
 *
 *  @return NSDictionary 或者 自定义参数模型
 */
- (id)smk_requestParameters;

/**
 *  配置request的路径、请求参数等
 */
- (void)smk_requestConfigures;


@end
