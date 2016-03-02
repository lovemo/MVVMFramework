//
//  BQViewModel.h
//  DevelopFramework
//
//  Created by momo on 15/12/23.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "MVVMHttp.h"
#import "AFNetworking.h"
#import "MVVMStore.h"
#import "SUIUtils.h"
#import "MVVMHttpConfig.h"

#ifdef DEBUG
#define BQLog(...) NSLog(__VA_ARGS__)
#else
#define BQLog(...)
#endif

static NSString * const MVVMRequestCache = @"MVVMRequestCache.sqlite";

typedef NS_ENUM(NSUInteger, MVVMHttpRequestType) {
    MVVMHttpRequestTypeGET = 0,
    MVVMHttpRequestTypePOST
};


@interface MVVMHttp ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) MVVMStore *store;
@end

@implementation MVVMHttp

- (MVVMStore *)store {
    if (_store == nil) {
        _store = [[MVVMStore alloc] init];
        NSString *cachesPath = [kPathOfCaches stringByAppendingPathComponent:MVVMRequestCache];
        [_store db_initDBWithPath:cachesPath];
    }
    return _store;
}

- (id)init{
    if (self = [super init]){
        // 创建请求管理者
        self.manager = [AFHTTPSessionManager manager];
        // 请求参数序列化类型
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 请求超时设定
        self.manager.requestSerializer.timeoutInterval = 10;
        // 设置请求ContentType
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    }
    return self;
}

#pragma mark -------------------- public --------------------

+ (MVVMHttp *)defaultMVVMHttp {
    static MVVMHttp *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)removeAllCaches {
    [[MVVMHttp defaultMVVMHttp].store db_clearTable:MVVMRequestCache];
}

+ (void)cancelAllOperations {
    [[MVVMHttp defaultMVVMHttp].manager.operationQueue cancelAllOperations];
}

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler
{
    [MVVMHttp requestMethod:MVVMHttpRequestTypeGET url:url params:params cachePolicy:MVVMHttpReloadIgnoringLocalCacheData success:successHandler failure:failureHandler];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(requestSuccessBlock)successHandler
     failure:(requestFailureBlock)failureHandler
{
    [MVVMHttp requestMethod:MVVMHttpRequestTypePOST url:url params:params cachePolicy:MVVMHttpReloadIgnoringLocalCacheData success:successHandler failure:failureHandler];
}

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
cachePolicy:(MVVMHttpRequestCachePolicy)cachePolicy
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler
{
    [MVVMHttp requestMethod:MVVMHttpRequestTypeGET url:url params:params cachePolicy:cachePolicy success:successHandler failure:failureHandler];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
 cachePolicy:(MVVMHttpRequestCachePolicy)cachePolicy
     success:(requestSuccessBlock)successHandler
     failure:(requestFailureBlock)failureHandler
{
    [MVVMHttp requestMethod:MVVMHttpRequestTypePOST url:url params:params cachePolicy:cachePolicy success:successHandler failure:failureHandler];
}

+ (void)put:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if (![MVVMHttpConfig sharedConfig].reachable) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    [[MVVMHttp defaultMVVMHttp].manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
    
}

+ (void)delete:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if (![MVVMHttpConfig sharedConfig].reachable) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    [[MVVMHttp defaultMVVMHttp].manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
    
}

/**
 下载文件，监听下载进度
 */
+ (void)download:(NSString *)url successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler {
    
    if (![MVVMHttpConfig sharedConfig].reachable) {
        progressHandler(nil);
        completionHandler(nil, nil);
        return;
    }
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progressHandler(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory :NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            BQLog(@"------下载失败-------%@",error);
        }
        completionHandler(response, error);
    }];
    
    [downloadTask resume];
    
}

/**
 *  发送一个POST请求
 *  @param fileConfig 文件相关参数模型
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 *  无上传进度监听
 */
+ (void)upload:(NSString *)url params:(NSDictionary *)params fileConfig:(MVVMHttpFileConfig *)fileConfig success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if (![MVVMHttpConfig sharedConfig].reachable) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    [[MVVMHttp defaultMVVMHttp].manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileConfig.fileData name:fileConfig.name fileName:fileConfig.fileName mimeType:fileConfig.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        BQLog(@"------上传失败-------%@",error);
        failureHandler(error);
    }];
    
}

/**
 上传文件，监听上传进度
 */
+ (void)upload:(NSString *)url params:(NSDictionary *)params fileConfig:(MVVMHttpFileConfig *)fileConfig successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler {
    
    if (![MVVMHttpConfig sharedConfig].reachable) {
        progressHandler(nil);
        completionHandler(nil, nil);
        return;
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileConfig.fileData name:fileConfig.name fileName:fileConfig.fileName mimeType:fileConfig.mimeType];
        
    } error:nil];
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      
                      progressHandler(uploadProgress);
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          completionHandler(nil, error);
                          BQLog(@"------上传失败-------%@",error);
                      } else {
                          completionHandler(responseObject, nil);
                          BQLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
    
}


#pragma mark -------------------- private --------------------

+ (void)requestMethod:(MVVMHttpRequestType)requestType
                  url:(NSString *)url
               params:(NSDictionary *)params
          cachePolicy:(MVVMHttpRequestCachePolicy)cachePolicy
              success:(requestSuccessBlock)successHandler
              failure:(requestFailureBlock)failureHandler
{
    if (cachePolicy == MVVMHttpReturnDefault) {
        [MVVMHttp requestMethod:requestType url:url params:params cachePolicy:MVVMHttpReturnDefault tableName:nil cacheKey:nil success:successHandler failure:failureHandler];
        return;
    }
    NSString *cacheKey = url;
    if (params) {
        if (![NSJSONSerialization isValidJSONObject:params]) return ; //参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [url stringByAppendingString:paramStr];
    }
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"[]{} // / : . @（#%-*+=_）\\|~(＜＞$%^&*)_+  { } " " : , “” " " \r \n  \" \"  "];
    NSString *cacheKeyUrl = [[cacheKey componentsSeparatedByCharactersInSet: set]componentsJoinedByString:@""];
    
    [[MVVMHttp defaultMVVMHttp].store db_createTableWithName:cacheKeyUrl];
    id object = [[MVVMHttp defaultMVVMHttp].store db_getObjectById:cacheKey fromTable:cacheKeyUrl];
    
    switch (cachePolicy) {
        case MVVMHttpReturnCacheDataThenLoad: { // 先返回缓存，同时请求
            if (object) {
                successHandler(object);
            }
            break;
        }
        case MVVMHttpReloadIgnoringLocalCacheData: { // 忽略本地缓存直接请求
            // 不做处理，直接请求
            break;
        }
        case MVVMHttpReturnCacheDataElseLoad: { // 有缓存就返回缓存，没有就请求
            if (object) { // 有缓存
                successHandler(object);
                return ;
            }
            break;
        }
        case MVVMHttpReturnCacheDataDontLoad: { // 有缓存就返回缓存,从不请求（用于没有网络）
            if (object) { // 有缓存
                successHandler(object);
            }
            return ; // 退出从不请求
        }
        default: {
            break;
        }
    }
    [MVVMHttp requestMethod:requestType url:url params:params cachePolicy:MVVMHttpReloadIgnoringLocalCacheData tableName:cacheKeyUrl cacheKey:cacheKey success:successHandler failure:failureHandler];
}

+ (void)requestMethod:(MVVMHttpRequestType)requestType
                  url:(NSString *)url
               params:(NSDictionary *)params
          cachePolicy:(MVVMHttpRequestCachePolicy)cachePolicy
            tableName:(NSString *)tableName
             cacheKey:(NSString *)cacheKey
              success:(requestSuccessBlock)successHandler
              failure:(requestFailureBlock)failureHandler
{
    
    [[MVVMHttp defaultMVVMHttp].manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [MVVMHttp defaultMVVMHttp].manager.requestSerializer.timeoutInterval = [MVVMHttp defaultMVVMHttp].timeoutInterval;
    [[MVVMHttp defaultMVVMHttp].manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    switch (requestType) {
        case MVVMHttpRequestTypeGET: {
            if ([MVVMHttpConfig sharedConfig].reachable) {
                // 2.发送请求
                [[MVVMHttp defaultMVVMHttp].manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (successHandler) {
                        if (cachePolicy != MVVMHttpReturnDefault) {
                            if (responseObject) {
                                [[MVVMHttp defaultMVVMHttp].store db_putObject:responseObject withId:cacheKey intoTable:tableName];
                            }
                        }
                        successHandler(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failureHandler) {
                        failureHandler(error);
                    }
                }];
            } else {
                successHandler(nil);
                failureHandler(nil);
                [MVVMHttp showExceptionDialog];
            }
            break;
        }
        case MVVMHttpRequestTypePOST: {
            if ([MVVMHttpConfig sharedConfig].reachable) {
                // 2.发送请求
                [[MVVMHttp defaultMVVMHttp].manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (successHandler) {
                        if (cachePolicy != MVVMHttpReturnDefault) {
                            if (responseObject) {
                                [[MVVMHttp defaultMVVMHttp].store db_putObject:responseObject withId:cacheKey intoTable:tableName];
                            }
                        }
                        successHandler(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failureHandler) {
                        failureHandler(error);
                    }
                }];
            } else {
                successHandler(nil);
                failureHandler(nil);
                [MVVMHttp showExceptionDialog];
            }
            
            break;
        }
        default:
            break;
    }
}

// 弹出网络错误提示框
+ (void)showExceptionDialog
{
    if ([MVVMHttp defaultMVVMHttp].alert) {
        return;
    }
    [MVVMHttp defaultMVVMHttp].alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                  message:@"网络异常，请检查网络连接"
                                                                 delegate:self
                                                        cancelButtonTitle:@"好的"
                                                        otherButtonTitles:nil, nil];
    [[MVVMHttp defaultMVVMHttp].alert show];
}


@end
