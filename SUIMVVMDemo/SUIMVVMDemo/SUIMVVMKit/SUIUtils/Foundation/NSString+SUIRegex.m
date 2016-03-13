//
//  NSString+SUIRegex.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSString+SUIRegex.h"

@implementation NSString (SUIRegex)


- (NSString *)sui_regex:(NSString *)cRegex
{
    if (cRegex.length == 0) return nil;
    NSRange curRange = [self rangeOfString:cRegex options:NSRegularExpressionSearch];
    if (curRange.location == NSNotFound) return nil;
    NSString *curStr = [self substringWithRange:curRange];
    return curStr;
}


- (BOOL)sui_validateByRegex:(NSString *)cRegex
{
    NSPredicate *curPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",cRegex];
    BOOL ret = [curPredicate evaluateWithObject:self];
    return ret;
}

- (BOOL)sui_validateNickname
{
    NSString *curRegex = @"^[0-9a-zA-Z\u4e00-\u9fa5]+$";
    BOOL ret = [self sui_validateByRegex:curRegex];
    return ret;
}

- (BOOL)sui_validateMobile
{
    /**
     *  手机号以13、15、18、170开头，8个 \d 数字字符
     *  小灵通 区号：010,020,021,022,023,024,025,027,028,029 还有未设置的新区号xxx
     */
    NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|70[059])\\d{7}$";//除4以外的所有个位整数，不能使用[^4,\\d]匹配，这里是否iOS Bug?
    NSString *phsRegex = @"^0(10|2[0-57-9]|\\d{3})\\d{7,8}$";
    BOOL ret = [self sui_validateByRegex:mobileNoRegex];
    BOOL ret1 = [self sui_validateByRegex:phsRegex];
    return (ret || ret1);
}

- (BOOL)sui_validateIPAddress
{
    NSString *curRegex = @"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$";
    BOOL ret = [self sui_validateByRegex:curRegex];
    if (ret) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        return v;
    }
    return NO;
}

- (BOOL)sui_validateURL
{
    NSString *curRegex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    BOOL ret = [self sui_validateByRegex:curRegex];
    return ret;
}

- (BOOL)sui_validateEmail
{
    NSString *curRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    BOOL ret = [self sui_validateByRegex:curRegex];
    return ret;
}

- (BOOL)sui_validateIDCardNumber
{
    NSString *curRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    BOOL ret = [self sui_validateByRegex:curRegex];
    return ret;
}

- (BOOL)sui_validateCarNumber
{
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    NSString *curRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";//其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    BOOL ret = [self sui_validateByRegex:curRegex];
    return ret;
}


@end
