//
//  FirstVC.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "FirstVC.h"
#import "BQCell.h"
#import "FirstModel.h"
#import <SUIMVVMKit.h>
#import "SecondVC.h"
#import "BQViewModel.h"
#import "TestViewDelegate.h"

static NSString *const MyCellIdentifier = @"BQCell" ;  // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface FirstVC ()

@property (nonatomic, weak) IBOutlet UITableView *table;

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
    __weak typeof(self) weakSelf = self;
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.table.tableHander = [[TestViewDelegate alloc]initWithViewModel:[[BQViewModel alloc]init]
                                                     cellIdentifiersArray:@[MyCellIdentifier]
                                                           didSelectBlock:^(NSIndexPath *indexPath, id item) {
                                                               
                                                               SecondVC *vc = (SecondVC *)[UIViewController svv_viewControllerWithStoryBoardName:@"Main" identifier:@"SecondVCID"];
                                                               [weakSelf.navigationController pushViewController:vc animated:YES];
                                                               NSLog(@"click row : %@",@(indexPath.row)) ;
                                                           }];
}

@end
