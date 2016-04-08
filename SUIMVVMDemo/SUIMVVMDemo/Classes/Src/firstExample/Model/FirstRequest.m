//
//  FirstRequest.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/8.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "FirstRequest.h"

@implementation FirstRequest

- (void)smk_requestConfigures {
    self.smk_url = @"https://api.douban.com/v2/book/search";
}

- (id)smk_requestParameters {
    return @{@"q" : @"基础"};
}

@end
