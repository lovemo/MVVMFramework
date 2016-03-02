//
//  SUITool+Delay.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "SUITool+Delay.h"

@implementation SUITool (Delay)


+ (SUIToolDelayTask)delay:(NSTimeInterval)delay cb:(void (^)(void))completion;
{
    __block dispatch_block_t closure = completion;
    __block SUIToolDelayTask currTask = nil;
    
    SUIToolDelayTask delayedBlock = ^(BOOL cancel) {
        if (cancel == NO) {
            dispatch_async(dispatch_get_main_queue(), closure);
        }
        closure = nil;
        currTask = nil;
    };
    
    currTask = delayedBlock;
    
    [self sui_delayExecutive:delay cb:^{
        if (currTask) currTask(NO);
    }];
    return currTask;
}

+ (void)cancelDelayTask:(SUIToolDelayTask)cTask
{
    if (cTask) cTask(YES);
}

+ (void)sui_delayExecutive:(NSTimeInterval)delayInSeconds cb:(void (^)(void))completionBlock
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), completionBlock);
}


@end
