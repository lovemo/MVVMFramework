//
//  NSString+Matcher.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/23.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "NSString+Matcher.h"

@implementation NSString (Matcher)

- (NSString *)sui_regex:(NSString *)cRegex
{
    if (cRegex.length == 0) return nil;
    
    NSRange curRange = [self rangeOfString:cRegex options:NSRegularExpressionSearch];
    if (curRange.location == NSNotFound) return nil;
    
    NSString *curStr = [self substringWithRange:curRange];
    return curStr;
}

@end
