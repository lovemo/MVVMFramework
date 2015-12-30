//
//  BQViewModel.h
//  DevelopFramework
//
//  Created by momo on 15/12/23.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQHttpTool.h"
#import "AFNetworking.h"

@interface BQHttpTool ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation BQHttpTool

- (id)init{
    if (self = [super init]){
        // 创建请求管理者
        self.manager = [AFHTTPSessionManager manager];
        // 请求参数序列化类型
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置请求ContentType
        // self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}

+ (BQHttpTool *)defaultHttpTool {
    static BQHttpTool *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
  
    if ([AFNetworkReachabilityManager manager].isReachable) {
        // 2.发送请求
        [[BQHttpTool defaultHttpTool].manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } else {
        [BQHttpTool showExceptionDialog];
    }
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{

    if ([AFNetworkReachabilityManager manager].isReachable) {
        // 2.发送请求
        [[BQHttpTool defaultHttpTool].manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    } else {
        [BQHttpTool showExceptionDialog];
    }
    
}
//弹出网络错误提示框
+ (void)showExceptionDialog
{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:@"网络异常，请检查网络连接"
                               delegate:self
                      cancelButtonTitle:@"好的"
                      otherButtonTitles:nil, nil] show];
}
@end
