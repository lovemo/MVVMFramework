//
//  BQViewModel.h
//  DevelopFramework
//
//  Created by momo on 15/12/23.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQHttpTool.h"
#import "AFNetworking.h"
#include "netdb.h"
#import "YYCache.h"


#ifdef DEBUG
#define BQLog(...) NSLog(__VA_ARGS__)
#else
#define BQLog(...)
#endif

static NSString * const BQHttpToolRequestCache = @"BQHttpToolRequestCache";

typedef NS_ENUM(NSUInteger, BQHttpToolRequestType) {
    BQHttpToolRequestTypeGET = 0,
    BQHttpToolRequestTypePOST
};


@interface BQHttpTool ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) YYCache *cache;
@property (nonatomic, strong) UIAlertView *alert;
@end

@implementation BQHttpTool

- (id)init{
    if (self = [super init]){
        // 创建请求管理者
        self.manager = [AFHTTPSessionManager manager];
        // 请求参数序列化类型
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 请求超时设定
        self.manager.requestSerializer.timeoutInterval = 10;
        // 设置请求ContentType
        // self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    }
    return self;
}

#pragma mark -------------------- public --------------------

+ (BQHttpTool *)defaultHttpTool {
    static BQHttpTool *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)removeAllCaches {
    [[BQHttpTool defaultHttpTool].cache removeAllObjects];
}

+ (void)removeCachesForKey:(NSString *)key {
    [[BQHttpTool defaultHttpTool].cache removeObjectForKey:key];
}

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler
{
    [BQHttpTool requestMethod:BQHttpToolRequestTypeGET url:url params:params cachePolicy:BQHttpToolReturnCacheDataThenLoad success:successHandler failure:failureHandler];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(requestSuccessBlock)successHandler
     failure:(requestFailureBlock)failureHandler
{
    [BQHttpTool requestMethod:BQHttpToolRequestTypePOST url:url params:params cachePolicy:BQHttpToolReturnCacheDataThenLoad success:successHandler failure:failureHandler];
}

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy
    success:(requestSuccessBlock)successHandler
    failure:(requestFailureBlock)failureHandler
{
    [BQHttpTool requestMethod:BQHttpToolRequestTypeGET url:url params:params cachePolicy:cachePolicy success:successHandler failure:failureHandler];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
 cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy
     success:(requestSuccessBlock)successHandler
     failure:(requestFailureBlock)failureHandler
{
    [BQHttpTool requestMethod:BQHttpToolRequestTypePOST url:url params:params cachePolicy:cachePolicy success:successHandler failure:failureHandler];
}

+ (void)put:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if (![self isConnectionAvailable]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    [[BQHttpTool defaultHttpTool].manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
    
}

+ (void)delete:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if (![self isConnectionAvailable]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    [[BQHttpTool defaultHttpTool].manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
    
}

/**
 下载文件，监听下载进度
 */
+ (void)download:(NSString *)url successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler {
    
    if (![self isConnectionAvailable]) {
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
+ (void)upload:(NSString *)url params:(NSDictionary *)params fileConfig:(BQFileConfig *)fileConfig success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if (![self isConnectionAvailable]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    [[BQHttpTool defaultHttpTool].manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
+ (void)upload:(NSString *)url params:(NSDictionary *)params fileConfig:(BQFileConfig *)fileConfig successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler {
    
    if (![self isConnectionAvailable]) {
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

+ (void)requestMethod:(BQHttpToolRequestType)requestType
                  url:(NSString *)url
               params:(NSDictionary *)params
          cachePolicy:(BQHttpToolRequestCachePolicy)cachePolicy
              success:(requestSuccessBlock)successHandler
              failure:(requestFailureBlock)failureHandler
{
    NSString *cacheKey = url;
    if (params) {
        if (![NSJSONSerialization isValidJSONObject:params]) return ; //参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [url stringByAppendingString:paramStr];
    }
    
    YYCache *cache = [[YYCache alloc] initWithName:BQHttpToolRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    id object = [cache objectForKey:cacheKey];
    [BQHttpTool defaultHttpTool].cache = cache;
    
    switch (cachePolicy) {
        case BQHttpToolReturnCacheDataThenLoad: { // 先返回缓存，同时请求
            if (object) {
                successHandler(object);
            }
            break;
        }
        case BQHttpToolReloadIgnoringLocalCacheData: { // 忽略本地缓存直接请求
            // 不做处理，直接请求
            break;
        }
        case BQHttpToolReturnCacheDataElseLoad: { // 有缓存就返回缓存，没有就请求
            if (object) { // 有缓存
                successHandler(object);
                return ;
            }
            break;
        }
        case BQHttpToolReturnCacheDataDontLoad: { // 有缓存就返回缓存,从不请求（用于没有网络）
            if (object) { // 有缓存
                successHandler(object);
            }
            return ; // 退出从不请求
        }
        default: {
            break;
        }
    }
    [BQHttpTool requestMethod:requestType url:url params:params cache:cache cacheKey:cacheKey success:successHandler failure:failureHandler];
}

+ (void)requestMethod:(BQHttpToolRequestType)requestType
                  url:(NSString *)url
               params:(NSDictionary *)params
                cache:(YYCache *)cache
             cacheKey:(NSString *)cacheKey
              success:(requestSuccessBlock)successHandler
              failure:(requestFailureBlock)failureHandler
{

    [[BQHttpTool defaultHttpTool].manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [BQHttpTool defaultHttpTool].manager.requestSerializer.timeoutInterval = [BQHttpTool defaultHttpTool].timeoutInterval;
    [[BQHttpTool defaultHttpTool].manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    switch (requestType) {
        case BQHttpToolRequestTypeGET: {
            if ([self isConnectionAvailable]) {
                // 2.发送请求
                [[BQHttpTool defaultHttpTool].manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if (successHandler) {
                        [cache setObject:responseObject forKey:cacheKey];   // YYCache 已经做了responseObject为空处理
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
                [BQHttpTool showExceptionDialog];
            }
            break;
        }
        case BQHttpToolRequestTypePOST: {
            if ([self isConnectionAvailable]) {
                // 2.发送请求
                [[BQHttpTool defaultHttpTool].manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (successHandler) {
                        [cache setObject:responseObject forKey:cacheKey];   // YYCache 已经做了responseObject为空处理
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
                [BQHttpTool showExceptionDialog];
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
    if ([BQHttpTool defaultHttpTool].alert) {
        return;
    }
    [BQHttpTool defaultHttpTool].alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"网络异常，请检查网络连接"
                                                                   delegate:self
                                                          cancelButtonTitle:@"好的"
                                                          otherButtonTitles:nil, nil];
    [[BQHttpTool defaultHttpTool].alert show];
}
// 查看网络状态是否给力
+ (BOOL)isConnectionAvailable
{
    // 创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    /**
     *  SCNetworkReachabilityRef: 用来保存创建测试连接返回的引用
     *
     *  SCNetworkReachabilityCreateWithAddress: 根据传入的地址测试连接.
     *  第一个参数可以为NULL或kCFAllocatorDefault
     *  第二个参数为需要测试连接的IP地址,当为0.0.0.0时则可以查询本机的网络连接状态.
     *  同时返回一个引用必须在用完后释放.
     *  PS: SCNetworkReachabilityCreateWithName: 这个是根据传入的网址测试连接,
     *  第二个参数比如为"www.apple.com",其他和上一个一样.
     *
     *  SCNetworkReachabilityGetFlags: 这个函数用来获得测试连接的状态,
     *  第一个参数为之前建立的测试连接的引用,
     *  第二个参数用来保存获得的状态,
     *  如果能获得状态则返回TRUE，否则返回FALSE
     *
     */
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flagsn");
        return NO;
    }
    
    /**
     *  kSCNetworkReachabilityFlagsReachable: 能够连接网络
     *  kSCNetworkReachabilityFlagsConnectionRequired: 能够连接网络,但是首先得建立连接过程
     *  kSCNetworkReachabilityFlagsIsWWAN: 判断是否通过蜂窝网覆盖的连接,
     *  比如EDGE,GPRS或者目前的3G.主要是区别通过WiFi的连接.
     *
     */
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

@end

