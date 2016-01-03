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
 *  选中UITableViewCell的Block
 */
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;


 // - - - - - -- - - - - - - - -- - - - - -- -- - - - - -- 创建类 - -- - - - - -- -- - - - - -- - - - - - - - -- - - - - -- -//

@class BQBaseViewModel;
@interface XTableDataDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

/**
 *  初始化方法
 */
- (id)initWithSelfFriendsDelegate:(BQBaseViewModel *)viewModel
     cellIdentifier:(NSString *)aCellIdentifier
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
