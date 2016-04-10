//
//  ThirdRequest.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/8.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "ThirdRequest.h"

@implementation ThirdRequest

- (void)smk_requestConfigures {

    self.smk_scheme = @"https";
    self.smk_host = @"api.douban.com";
    self.smk_path = @"/v2/book/search";
    self.smk_method = SMKRequestMethodGET;

}

- (id)smk_requestParameters {
    return @{@"q": @"基础"};
}

@end
