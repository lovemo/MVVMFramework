//
//  UITableView+SUIHelper.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/20.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UITableView+SUIHelper.h"
#import "NSObject+SUIAdditions.h"
#import "SUITableHelper.h"

@implementation UITableView (SUIHelper)


- (SUITableHelper *)sui_tableHelper
{
    SUITableHelper *curTableHelper = [self sui_getAssociatedObjectWithKey:@selector(sui_tableHelper)];
    if (curTableHelper) return curTableHelper;
    
    curTableHelper = [SUITableHelper new];
    self.sui_tableHelper = curTableHelper;
    return curTableHelper;
}
- (void)setSui_tableHelper:(SUITableHelper *)sui_tableHelper
{
    [self sui_setAssociatedRetainObject:sui_tableHelper key:@selector(sui_tableHelper)];
    self.delegate = sui_tableHelper;
    self.dataSource = sui_tableHelper;
    sui_tableHelper.sui_tableView = self;
}


- (BOOL)sui_autoSizingCell
{
    return [[self sui_getAssociatedObjectWithKey:@selector(sui_autoSizingCell)] boolValue];
}
- (void)setSui_autoSizingCell:(BOOL)sui_autoSizingCell
{
    [self sui_setAssociatedRetainObject:@(sui_autoSizingCell) key:@selector(sui_autoSizingCell)];
}


- (void)sui_resetDataAry:(NSArray *)newDataAry
{
    [self sui_resetDataAry:newDataAry forSection:0];
}
- (void)sui_resetDataAry:(NSArray *)newDataAry forSection:(NSInteger)cSection
{
    [self.sui_tableHelper resetDataAry:newDataAry forSection:cSection];
}
- (void)sui_reloadDataAry:(NSArray *)newDataAry
{
    [self sui_reloadDataAry:newDataAry forSection:0];
}
- (void)sui_reloadDataAry:(NSArray *)newDataAry forSection:(NSInteger)cSection
{
    [self.sui_tableHelper reloadDataAry:newDataAry forSection:cSection];
}
- (void)sui_addDataAry:(NSArray *)newDataAry
{
    [self sui_addDataAry:newDataAry forSection:0];
}
- (void)sui_addDataAry:(NSArray *)newDataAry forSection:(NSInteger)cSection
{
    [self.sui_tableHelper addDataAry:newDataAry forSection:cSection];
}
- (void)sui_insertData:(id)cModel AtIndex:(NSIndexPath *)cIndexPath;
{
    [self.sui_tableHelper insertData:cModel AtIndex:cIndexPath];
}
- (void)sui_deleteDataAtIndex:(NSIndexPath *)cIndexPath
{
    [self.sui_tableHelper deleteDataAtIndex:cIndexPath];
}


@end
