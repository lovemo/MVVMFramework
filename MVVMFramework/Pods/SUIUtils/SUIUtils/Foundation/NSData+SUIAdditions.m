//
//  NSData+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSData+SUIAdditions.h"

@implementation NSData (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Prehash
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Prehash

- (NSString *)sui_toUTF8String
{
    NSString *curString = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    return curString;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Base64
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Base64

- (NSString *)sui_base64Encode
{
    if (self.length == 0) return nil;
    NSString *curStr = [self base64EncodedStringWithOptions:0];
    return curStr;
}


@end
