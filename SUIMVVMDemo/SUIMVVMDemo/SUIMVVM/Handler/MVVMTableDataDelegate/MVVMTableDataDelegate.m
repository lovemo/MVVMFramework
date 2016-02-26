//
//  MVVMCollectionDataDelegate.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "MVVMTableDataDelegate.h"
#import "UITableViewCell+Extension.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MVVMBaseViewModel.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface MVVMTableDataDelegate ()

@end

@implementation MVVMTableDataDelegate

- (NSArray *)cellIdentifierArray {
    if (_cellIdentifierArray == nil) {
        _cellIdentifierArray = [NSArray array];
    }
    return _cellIdentifierArray;
}

- (id)initWithViewModel:(MVVMBaseViewModel *)viewModel
    cellIdentifiersArray:(NSArray *)cellIdentifiersArray
    didSelectBlock:(didSelectCellBlock)didselectBlock
{
    self = [super init] ;
    if (self) {
        self.viewModel = viewModel;
        self.cellIdentifierArray = cellIdentifiersArray ;
        self.didSelectCellBlock = didselectBlock ;
    }
    
    return self ;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.viewModel.dataArrayList[indexPath.row];
}

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table
{
    
    table.dataSource = self ;
    table.delegate   = self ;
    
    [UITableViewCell registerTable:table nibIdentifier:self.cellIdentifierArray[0]] ;
    table.tableFooterView = [UIView new];
    __weak typeof(self) weakSelf = self;
    __weak typeof(table) weakTable = table;
 
    [SVProgressHUD show];
    // 下拉刷新
    table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.viewModel vm_getDataSuccessHandler:^{
            [SVProgressHUD dismiss];
            [weakTable reloadData];
        }];
        // 结束刷新
        [weakTable.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];

    [table.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    table.mj_header.automaticallyChangeAlpha = YES;

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel vm_numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifierArray[0] forIndexPath:indexPath] ;
    
    [cell configure:cell customObj:item indexPath:indexPath];
    //  self.configureCellBlock(indexPath,item,cell) ;
    return cell ;
 
}

#pragma mark --c
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    __weak typeof(self) weakSelf = self;
   
    return [tableView fd_heightForCellWithIdentifier:weakSelf.cellIdentifierArray[0] cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        [cell configure:cell customObj:item indexPath:indexPath];
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id item = [self itemAtIndexPath:indexPath] ;
    self.didSelectCellBlock(indexPath,item) ;
}

@end
