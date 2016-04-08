//
//  SMKViewModelProtocol.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/8.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求成功block
 */
typedef void (^successBlock)(id responseObject);
/**
 *  请求失败block
 */
typedef void (^failureBlock) (NSError *error);
/**
 *  请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);
/**
 *  监听进度响应block
 */
typedef void (^progressBlock)(NSProgress * progress);


@protocol SMKViewModelProtocol <NSObject>

@optional
/**
 *  返回指定viewModel的所引用的控制器
 */
- (void)smk_viewModelWithViewController:(UIViewController *)viewController;

/**
 *  加载数据
 */
- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure;


@end
