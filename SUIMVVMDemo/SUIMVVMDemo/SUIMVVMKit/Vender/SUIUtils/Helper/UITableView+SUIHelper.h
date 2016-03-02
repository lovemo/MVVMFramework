//
//  UITableView+SUIHelper.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/20.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SUITableHelper;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SUIHelper)


@property (null_resettable,strong) SUITableHelper *sui_tableHelper;

@property (nonatomic) IBInspectable BOOL sui_autoSizingCell;

- (void)sui_resetDataAry:(NSArray *)newDataAry;
- (void)sui_resetDataAry:(NSArray *)newDataAry forSection:(NSInteger)cSection;
- (void)sui_reloadDataAry:(NSArray *)newDataAry;
- (void)sui_reloadDataAry:(NSArray *)newDataAry forSection:(NSInteger)cSection;
- (void)sui_addDataAry:(NSArray *)newDataAry;
- (void)sui_addDataAry:(NSArray *)newDataAry forSection:(NSInteger)cSection;
- (void)sui_insertData:(id)cModel AtIndex:(NSIndexPath *)cIndexPath;
- (void)sui_deleteDataAtIndex:(NSIndexPath *)cIndexPath;


@end

NS_ASSUME_NONNULL_END
