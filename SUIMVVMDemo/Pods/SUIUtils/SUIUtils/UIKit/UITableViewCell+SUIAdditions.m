//
//  UITableViewCell+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/20.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UITableViewCell+SUIAdditions.h"
#import "NSObject+SUIAdditions.h"
#import "UIView+SUIAdditions.h"

@implementation UITableViewCell (SUIAdditions)


- (UITableView *)sui_tableView
{
    UITableView *curTableView = [self sui_getAssociatedObjectWithKey:@selector(sui_tableView)];
    if (curTableView) return curTableView;
    
    curTableView = [self sui_findSupview:@"UITableView"];
    if (curTableView) {
        self.sui_tableView = curTableView;
    }
    return curTableView;
}
- (void)setSui_tableView:(UITableView *)sui_tableView
{
    [self sui_setAssociatedAssignObject:sui_tableView key:@selector(sui_tableView)];
}


@end
