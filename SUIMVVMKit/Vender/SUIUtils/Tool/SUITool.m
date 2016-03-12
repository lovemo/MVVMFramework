//
//  SUITool.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "SUITool.h"
#import "SUIMacro.h"

NSString *const sui_everLaunched = @"sui_everLaunched";
NSString *const sui_everVersion = @"sui_everVersion";

@interface SUITool ()

@property (nonatomic) SUILaunchedType launchedType;

@end

@implementation SUITool


uSharedInstanceWithCommonInit

- (void)commonInit
{
    [self updateVersion];
}

- (void)updateVersion
{
    if (gUserDefaultsBoolForKey(sui_everLaunched))
    {
        NSString *cVersion = kVersion;
        NSString *eVersion = [SUITool previousVersion];
        
        if ([eVersion isEqualToString:cVersion]) {
            self.launchedType = SUILaunchedLatestVersion;
            SUILogInfo(@"ever launched latest-version CurrVersion ⤭ %@ ⤪", cVersion);
        }
        else
        {
            [gUserDefaults setObject:cVersion forKey:sui_everVersion];
            [gUserDefaults synchronize];
            
            self.launchedType = SUILaunchedUpdateVersion;
            SUILogInfo(@"ever launched update-version EverVersion ⤭ %@ ⤪  CurrVersion ⤭ %@ ⤪", eVersion, cVersion);
        }
    }
    else
    {
        [gUserDefaults setBool:YES forKey:sui_everLaunched];
        [gUserDefaults setObject:kVersion forKey:sui_everVersion];
        [gUserDefaults synchronize];
        
        self.launchedType = SUILaunchedFirstLaunched;
        SUILogInfo(@"first launched CurrVersion ⤭ %@ ⤪", kVersion);
    }
}

+ (SUILaunchedType)launchedType
{
    return [[self sharedInstance] launchedType];
}

+ (NSString *)previousVersion
{
    return gUserDefaultsObjForKey(sui_everVersion);
}


@end
