//
//  NSObject+SMKRequest.h
//  SMKMVVM
//
//  Created by yuantao on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    /** GET */
    SMKRequestMethodGET,
    /** POST */
    SMKRequestMethodPOST,
    /** UPLOAD */
    SMKRequestMethodUPLOAD,
    /** DOWNLOAD */
    SMKRequestMethodDOWNLOAD
    
} SMKRequestMethod;


@class SMKRequestFileConfig;
@interface NSObject (SMKRequest)

/**
 *  scheme (eg: http, https, ftp)
 */
@property (nonatomic, copy, nonnull) NSString *smk_scheme;

/**
 *  host
 */
@property (nonatomic, copy, nonnull) NSString *smk_host;

/**
 *  path
 */
@property (nonatomic, copy, nonnull) NSString *smk_path;

/**
 *  method
 */
@property (nonatomic, assign) SMKRequestMethod smk_method;

/**
 *  url (如果设置了url，则不需要在设置scheme，host，path 属性)
 */
@property (nonatomic, copy, nonnull) NSString *smk_url;

/**
 *  parameters
 */
@property (nonatomic, retain, nonnull) id smk_params;

/**
 *  fileConfig
 */
@property (nonatomic, retain, nonnull) SMKRequestFileConfig *smk_fileConfig;

@end
