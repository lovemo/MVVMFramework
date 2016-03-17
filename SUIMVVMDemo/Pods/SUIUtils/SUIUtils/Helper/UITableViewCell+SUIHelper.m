//
//  UITableViewCell+SUIHelper.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/20.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UITableViewCell+SUIHelper.h"
#import "NSObject+SUIAdditions.h"

@implementation UITableViewCell (SUIHelper)


- (NSIndexPath *)sui_indexPath
{
    NSIndexPath *curIndexPath = [self sui_getAssociatedObjectWithKey:@selector(sui_indexPath)];
    return curIndexPath;
}
- (void)setSui_indexPath:(NSIndexPath *)sui_indexPath
{
    [self sui_setAssociatedRetainObject:sui_indexPath key:@selector(sui_indexPath)];
}


@end
