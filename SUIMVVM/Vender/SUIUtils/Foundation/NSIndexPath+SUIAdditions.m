//
//  NSIndexPath+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "NSIndexPath+SUIAdditions.h"
#import <UIKit/UIKit.h>

@implementation NSIndexPath (SUIAdditions)


- (instancetype)sui_previousRow
{
    NSIndexPath *curIndexPath = [NSIndexPath indexPathForRow:self.row-1
                                                   inSection:self.section];
    return curIndexPath;
}

- (instancetype)sui_nextRow
{
    NSIndexPath *curIndexPath = [NSIndexPath indexPathForRow:self.row+1
                                                   inSection:self.section];
    return curIndexPath;
}

- (instancetype)sui_previousSection
{
    NSIndexPath *curIndexPath = [NSIndexPath indexPathForRow:self.row
                                                   inSection:self.section-1];
    return curIndexPath;
}

- (instancetype)sui_nextSection
{
    NSIndexPath *curIndexPath = [NSIndexPath indexPathForRow:self.row
                                                   inSection:self.section+1];
    return curIndexPath;
}


@end
