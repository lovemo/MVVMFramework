//
//  XTableDataDelegate.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTableDataDelegate.h"
#import "UITableViewCell+Extension.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "BQViewModel.h"
#import "BQBaseViewModel.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface XTableDataDelegate ()

@property (nonatomic, copy) NSString *cellIdentifier ;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock ;
@property (nonatomic, copy) CellHeightBlock             heightConfigureBlock ;
@property (nonatomic, copy) DidSelectCellBlock          didSelectCellBlock ;
@property (nonatomic, strong) BQBaseViewModel *viewModel;

@end

@implementation XTableDataDelegate

-(id)initWithSelfFriendsDelegate:(BQBaseViewModel *)viewModel
    cellIdentifier:(NSString *)aCellIdentifier
    configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
    cellHeightBlock:(CellHeightBlock)aHeightBlock
    didSelectBlock:(DidSelectCellBlock)didselectBlock
{
    self = [super init] ;
    if (self) {
        self.viewModel = viewModel;
        self.cellIdentifier = aCellIdentifier ;
        self.configureCellBlock = aConfigureCellBlock ;
        self.heightConfigureBlock = aHeightBlock ;
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
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(table) weakTable = table;
 
    // 第一次刷新数据
    [self.viewModel getDataListSuccess:^{
        [weakTable reloadData];
    } failure:^{
    }];

    // 下拉刷新
    table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.viewModel getDataListSuccess:^{
                [weakTable reloadData];
            } failure:^{
            }];
            // 结束刷新
            [weakTable.mj_header endRefreshing];
        });
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier] ;
    if (!cell) {
        [UITableViewCell registerTable:tableView nibIdentifier:self.cellIdentifier] ;
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    }
    
    self.configureCellBlock(indexPath,item,cell) ;
    return cell ;
}

#pragma mark --
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UITableViewCell registerTable:tableView nibIdentifier:self.cellIdentifier] ;
    id item = [self itemAtIndexPath:indexPath] ;
    __weak typeof(self) weakSelf = self;
    return [tableView fd_heightForCellWithIdentifier:weakSelf.cellIdentifier configuration:^(UITableViewCell *cell) {
         weakSelf.configureCellBlock(indexPath,item,cell) ;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    self.didSelectCellBlock(indexPath,item) ;
}

@end
