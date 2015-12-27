//
//  ViewController.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQViewController.h"
#import "XTTableDataDelegate.h"
#import "BQCell.h"
#import "BQModel.h"
#import "UITableViewCell+Extension.h"
#import "BQViewController2.h"
#import "BQViewModel.h"

static NSString *const MyCellIdentifier = @"BQCell" ;  // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface BQViewController ()
@property (nonatomic, strong) XTTableDataDelegate *tableHander ;
@end

@implementation BQViewController

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
    __weak typeof(self) weakSelf = self;
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // 配置tableView的每个cell
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, BQModel *obj, UITableViewCell *cell) {
        [cell configure:cell customObj:obj indexPath:indexPath] ;
    } ;
    // 设置点击tableView的每个cell做的一些工作
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        [weakSelf.table deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BQViewController2 *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController2ID"];
        [weakSelf presentViewController:vc animated:YES completion:nil];
        NSLog(@"click row : %@",@(indexPath.row)) ;
    } ;
    // 将上述block设置给tableHander
    self.tableHander = [[XTTableDataDelegate alloc] initWithSelfFriendsDelegate:[[BQViewModel alloc]init]
                                                 cellIdentifier:MyCellIdentifier
                                                   configureCellBlock:configureCell
                                                   cellHeightBlock:nil
                                                   didSelectBlock:selectedBlock] ;
    // 设置UITableView的delegate和dataSourse为collectionHander
    [self.tableHander handleTableViewDatasourceAndDelegate:self.table] ;

}

@end
