//
//  SMKAction.m
//  SMKMVVM
//
//  Created by yuantao on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "SMKAction.h"
#import "AFNetworking.h"
#import "NSObject+SMKProperties.h"

static NSString * const SMKRequestUrlPath = @"SMKRequestUrlPath";
static NSString * const SMKRequestParameters = @"SMKRequestParameters";


@interface SMKAction ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation SMKAction

static id _instace;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedAction
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
        _sessionManager.requestSerializer.timeoutInterval = (!self.timeoutInterval ?: self.timeoutInterval);
    }
    return _sessionManager;
}

- (NSURLSessionTask *)sendRequest:(id<SMKRequestProtocol>)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    if ([request respondsToSelector:@selector(smk_requestConfigures)]) {
        [request smk_requestConfigures];
    } 
    
    NSObject *requestObject = (NSObject *)request;
    NSURLSessionTask *sessionDataTask = nil;
    
    switch (requestObject.smk_method) {
            
        case SMKRequestMethodGET:
           sessionDataTask = [self get:request progress:progress success:success failure:failure];
            break;
            
        case SMKRequestMethodPOST:
            sessionDataTask = [self post:request progress:progress success:success failure:failure];
            break;
            
        case SMKRequestMethodUPLOAD:
            sessionDataTask = [self upload:request progress:progress success:success failure:failure];
            break;
            
        case SMKRequestMethodDOWNLOAD:
            sessionDataTask = [self download:request progress:progress success:success failure:failure];
            break;
        default:
            break;
    }
    
    return sessionDataTask;
}

- (NSURLSessionTask *)sendRequestBlock:(id<SMKRequestProtocol> (^)())requestBlock progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    if (requestBlock) return [self sendRequest:requestBlock() progress:progress success:success failure:failure];
    return nil;
}

- (NSURLSessionDataTask *)get:(id<SMKRequestProtocol>)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    NSDictionary *requestDictionary = [self requestObject:request];
    NSString *urlPath = requestDictionary[SMKRequestUrlPath];
    NSDictionary *parameters = requestDictionary[SMKRequestParameters];
    
   return [self.sessionManager GET:urlPath parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
       if (progress) {
           if (downloadProgress) progress(downloadProgress);
       }
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       if (success) {
           if (responseObject) success(responseObject);
       }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if (failure) {
           if (error) failure(error);
       }
   }];
}

- (NSURLSessionDataTask *)post:(id<SMKRequestProtocol>)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    NSDictionary *requestDictionary = [self requestObject:request];
    NSString *urlPath = requestDictionary[SMKRequestUrlPath];
    NSDictionary *parameters = requestDictionary[SMKRequestParameters];
    
    return [self.sessionManager POST:urlPath parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            if (uploadProgress) progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (responseObject) success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (error) failure(error);
        }
    }];
}

- (NSURLSessionDownloadTask *)download:(id<SMKRequestProtocol>)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    NSDictionary *requestDictionary = [self requestObject:request];
    NSString *urlPath = requestDictionary[SMKRequestUrlPath];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:req progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            if (downloadProgress) progress(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory :NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            if (error) failure(error);
        }
        if (success) {
            if (response) success(response);
        }
    }];
    
    [downloadTask resume];
    return downloadTask;
}

- (NSURLSessionDataTask *)upload:(id<SMKRequestProtocol>)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    NSDictionary *requestDictionary = [self requestObject:request];
    NSString *urlPath = requestDictionary[SMKRequestUrlPath];
    NSDictionary *parameters = requestDictionary[SMKRequestParameters];
    
    NSObject *requestObject = (NSObject *)request;
    
   return [self.sessionManager POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:requestObject.smk_fileConfig.fileData name:requestObject.smk_fileConfig.name fileName:requestObject.smk_fileConfig.fileName mimeType:requestObject.smk_fileConfig.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            if (uploadProgress) progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (responseObject) success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (error) failure(error);
        }
    }];
    
}

- (NSDictionary *)requestObject:(id<SMKRequestProtocol>)request {

    NSObject *requestObject = (NSObject *)request;
    
    // urlPath
    NSString *urlPath = nil;
    if (requestObject.smk_url.length) {
        urlPath = requestObject.smk_url;
    } else {
        urlPath = [NSString stringWithFormat:@"%@://%@%@",requestObject.smk_scheme, requestObject.smk_host, requestObject.smk_path];
    }
 
    // parameters
    id parameters = nil;
    if ([request respondsToSelector:@selector(smk_requestParameters)]) {
        parameters = [request smk_requestParameters];
    } else if ([request respondsToSelector:@selector(setSmk_params:)]) {
        parameters = requestObject.smk_params;
    }

    return @{
                    SMKRequestUrlPath : urlPath,
                    SMKRequestParameters : parameters ? : @""
                };
}

- (void)cancelAllOperations {
    [self.sessionManager.operationQueue cancelAllOperations];
}

- (BOOL)isReachable {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

- (BOOL)isReachableViaWWAN {
    return [AFNetworkReachabilityManager sharedManager].isReachableViaWWAN;
}

- (BOOL)isReachableViaWiFi {
    return [AFNetworkReachabilityManager sharedManager].isReachableViaWiFi;
}

@end
