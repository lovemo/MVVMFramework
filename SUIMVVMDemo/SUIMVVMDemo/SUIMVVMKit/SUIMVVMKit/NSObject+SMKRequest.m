//
//  NSObject+SMKRequest.m
//  SMKMVVM
//
//  Created by yuantao on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "NSObject+SMKRequest.h"
#import <objc/runtime.h>

@implementation NSObject (SMKRequest)

/**
 *  scheme (eg: http, https, ftp)
 */
- (NSString *)smk_scheme {
    return objc_getAssociatedObject(self, @selector(smk_scheme));
}
- (void)setSmk_scheme:(NSString *)smk_scheme {
    objc_setAssociatedObject(self, @selector(smk_scheme), smk_scheme, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  host
 */
- (NSString *)smk_host {
    return objc_getAssociatedObject(self, @selector(smk_host));
}
- (void)setSmk_host:(NSString *)smk_host {
    objc_setAssociatedObject(self, @selector(smk_host), smk_host, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  path
 */
- (NSString *)smk_path {
    return objc_getAssociatedObject(self, @selector(smk_path));
}
- (void)setSmk_path:(NSString *)smk_path {
    objc_setAssociatedObject(self, @selector(smk_path), smk_path, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  method
 */
- (SMKRequestMethod)smk_method {
    return [objc_getAssociatedObject(self, @selector(smk_method)) integerValue];
}
- (void)setSmk_method:(SMKRequestMethod)smk_method {
    objc_setAssociatedObject(self, @selector(smk_method), @(smk_method), OBJC_ASSOCIATION_ASSIGN);
}

/**
 
 *  url
 */
- (NSString *)smk_url {
    return objc_getAssociatedObject(self, @selector(smk_url));
}
- (void)setSmk_url:(NSString *)smk_url {
    objc_setAssociatedObject(self, @selector(smk_url), smk_url, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  parameters
 */
- (id)smk_params {
     return objc_getAssociatedObject(self, @selector(smk_params));
}
- (void)setSmk_params:(id)smk_params {
    objc_setAssociatedObject(self, @selector(smk_params), smk_params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  fileConfig
 */
- (SMKRequestFileConfig *)smk_fileConfig {
    return objc_getAssociatedObject(self, @selector(smk_fileConfig));
}
- (void)setSmk_fileConfig:(SMKRequestFileConfig *)smk_fileConfig {
    objc_setAssociatedObject(self, @selector(smk_fileConfig), smk_fileConfig, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
