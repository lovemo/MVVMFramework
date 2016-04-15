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
/**
 *  将自己的信息返回给ViewManger的block
 */
typedef void (^ViewMangerInfosBlock)( );


@protocol SMKViewModelProtocol <NSObject>

@optional


- (void)smk_notice;

/**
 *  返回指定viewModel的所引用的控制器
 */
- (void)smk_viewModelWithViewController:(UIViewController *)viewController;

/**
 *  加载数据
 */
- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure;

/**
 *  传递模型给view
 */
- (void)smk_viewModelWithModelBlcok:(void (^)(id model))modelBlock;

/**
 *  处理ViewMangerInfosBlock
 */
- (ViewMangerInfosBlock)smk_viewModelWithViewMangerBlockOfInfos:(NSDictionary *)infos;

/**
 *  将viewModel中的信息通过代理传递给ViewManger
 *
 *  @param viewModel   viewModel自己
 *  @param infos 描述信息
 */
- (void)smk_viewModel:(id)viewModel withInfos:(NSDictionary *)infos;


@end
