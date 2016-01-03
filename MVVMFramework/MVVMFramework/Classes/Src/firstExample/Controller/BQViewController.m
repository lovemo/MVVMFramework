//
//  ViewController.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQViewController.h"
#import "XTableDataDelegate.h"
#import "BQCell.h"
#import "BQModel.h"
#import "UITableViewCell+Extension.h"
#import "BQViewController2.h"
#import "BQViewModel.h"

static NSString *const MyCellIdentifier = @"BQCell" ;  // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface BQViewController ()
@property (nonatomic, strong) XTableDataDelegate *tableHander ;
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
    self.tableHander = [XTableDataDelegate tableWithViewModel:[[BQViewModel alloc]init] cellIdentifier:MyCellIdentifier
                                didSelectBlock:^(NSIndexPath *indexPath, id item) {
                                    
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BQViewController2 *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController2ID"];
        [weakSelf presentViewController:vc animated:YES completion:nil];
        NSLog(@"click row : %@",@(indexPath.row)) ;
    }];
    
    [self.tableHander handleTableViewDatasourceAndDelegate:self.table] ;
}

@end
