//
//  SUITool+Delay.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/15.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "SUITool.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^SUIToolDelayTask)(BOOL cancel);

@interface SUITool (Delay)


+ (SUIToolDelayTask)delay:(NSTimeInterval)delay cb:(void (^)(void))completion;

+ (void)cancelDelayTask:(SUIToolDelayTask)cTask;


@end

NS_ASSUME_NONNULL_END
