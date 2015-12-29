//
//  XTableDataDelegate.h
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  配置UITableViewCell的内容Block
 */
typedef void (^TableViewCellConfigureBlock)(NSIndexPath *indexPath, id item, UITableViewCell *cell) ;
/**
 *  选中UITableViewCell的Block
 */
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UITableViewCell高度的Block (已集成UITableView+FDTemplateLayoutCell，现在创建的cell自动计算高度)
 */
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item) ;


 // - - - - - -- - - - - - - - -- - - - - -- -- - - - - -- 创建类 - -- - - - - -- -- - - - - -- - - - - - - - -- - - - - -- -//

@class BQBaseViewModel;
@interface XTableDataDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

/**
 *  初始化方法
 */
- (id)initWithSelfFriendsDelegate:(BQBaseViewModel *)viewModel
     cellIdentifier:(NSString *)aCellIdentifier
     configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
     cellHeightBlock:(CellHeightBlock)aHeightBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock ;
/**
 *  设置UITableView的Datasource和Delegate为self
 */
- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table ;
/**
 *  获取UITableView中Item所在的indexPath
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@end
