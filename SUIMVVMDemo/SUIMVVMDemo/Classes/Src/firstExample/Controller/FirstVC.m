//
//  FirstVC.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "FirstVC.h"
#import "SUIMVVMKit.h"
#import "SecondVC.h"
#import "BQViewModel.h"
#import "TestViewDelegate.h"
#import "MJRefresh.h"

static NSString *const MyCellIdentifier = @"BQCell" ;  // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface FirstVC ()

@property (nonatomic, weak) IBOutlet UITableView *table;

@property (nonatomic, strong) BQViewModel *viewModel;
@end

@implementation FirstVC

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    [self setupTableView] ;
}

/**
 *  tableView的一些初始化工作
 */
- (void)setupTableView
{
    
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(self.table) weakTable = self.table;
    
    // 下拉刷新
    self.table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.viewModel smk_viewModelWithGetDataSuccessHandler:^(NSArray *array) {
            [weakTable reloadData];
        }];
        // 结束刷新
        [weakTable.mj_header endRefreshing];
    }];
    
    [self.table.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.table.mj_header.automaticallyChangeAlpha = YES;
    
    
    //    self.table.tableHander = [[TestViewDelegate alloc]initWithCellIdentifiers:@[MyCellIdentifier] didSelectBlock:^(NSIndexPath *indexPath, id item) {
    //        SecondVC *vc = (SecondVC *)[UIViewController sui_viewControllerWithStoryboard:nil identifier:@"SecondVCID"];
    //        [weakSelf.navigationController pushViewController:vc animated:YES];
    //        NSLog(@"click row : %@",@(indexPath.row)) ;
    //    }];
    
    // cell自动计算高度
    self.table.sui_autoSizingCell = YES;
    // 注册cell
    [self.table.sui_tableHelper registerNibs:@[MyCellIdentifier]];
    // cell被选中时跳转
    [self.table.sui_tableHelper didSelect:^(NSIndexPath * _Nonnull cIndexPath, id  _Nonnull model) {
        [weakSelf sui_storyboardInstantiate:@"Main.SecondVCID"];
        NSLog(@"click row : %@",@(cIndexPath.row)) ;
    }];
    
    
    //    [self.viewModel smk_viewModelWithGetDataSuccessHandler:^(NSArray *array){
    //        [self.table.tableHander getItemsWithModelArray:^NSArray *{
    //            return array;
    //        } completion:^{
    //            [self.table reloadData];
    //        }];
    //    }];
    
    [self.viewModel smk_viewModelWithGetDataSuccessHandler:^(NSArray *array){
        [weakSelf.table sui_resetDataAry:array];
    }];
    
}

#pragma mark lazy
- (BQViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[BQViewModel alloc]init];
    }
    return _viewModel;
}

@end
