//
//  SUITool+OpenURL.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "SUITool+OpenURL.h"
#import <UIKit/UIKit.h>
#import "SUIMacro.h"

@implementation SUITool (OpenURL)


+ (BOOL)openMail:(NSString *)mail
{
    NSString *curURL = gFormat(@"mailto://%@", mail);
    BOOL ret =  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:curURL]];
    SUIAssert(ret, @"open mail failed Mail ⤭ %@ ⤪", mail);
    return ret;
}

+ (BOOL)openPhone:(NSString *)phone
{
    NSString *curURL = gFormat(@"telprompt://%@", phone);
    BOOL ret =  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:curURL]];
    SUIAssert(ret, @"open phone failed Phone ⤭ %@ ⤪", phone);
    return ret;
}

+ (BOOL)openAppStore:(NSString *)appId
{
    NSString *curURL = gFormat(@"itms-apps://itunes.apple.com/app/id%@", appId);
    BOOL ret = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:curURL]];
    SUIAssert(ret, @"open app store failed AppId ⤭ %@ ⤪", appId);
    return ret;
}


@end
