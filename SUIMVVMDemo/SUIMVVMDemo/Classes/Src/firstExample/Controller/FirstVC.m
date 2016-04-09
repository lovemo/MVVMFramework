//
//  FirstVC.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "FirstVC.h"
#import "FirstViewModel.h"
#import "MJRefresh.h"
#import "FirstTableViewModel.h"


@interface FirstVC ()

@property (nonatomic, weak) IBOutlet UITableView *table;

@property (nonatomic, strong) FirstViewModel *viewModel;
/**
 *  hudView
 */
@property (nonatomic, weak) UIView *hudView;

@property (nonatomic, strong) FirstTableViewModel *firstTableViewModel;

@end

@implementation FirstVC

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    [self setupTableView] ;
}

- (FirstTableViewModel *)firstTableViewModel {
    if (_firstTableViewModel == nil) {
        _firstTableViewModel = [[FirstTableViewModel alloc]init];
    }
    return _firstTableViewModel;
}

/**
 *  tableView的一些初始化工作
 */
- (void)setupTableView
{
    
    [self.firstTableViewModel handleWithTable:self.table];
    
    uWeakSelf
    self.hudView.hidden = NO;
   [self.viewModel smk_viewModelWithProgress:nil success:^(id responseObject) {
       self.hudView.hidden = YES;
       [weakSelf.firstTableViewModel getDataWithModelArray:^NSArray *{
           return responseObject;
       } completion:^{
            [weakSelf.table reloadData];
       }];
   } failure:^(NSError *error) {
       
   }];
    
}

#pragma mark lazy
- (FirstViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[FirstViewModel alloc]init];
    }
    return _viewModel;
}
- (UIView *)hudView {
    if (_hudView == nil) {
        UIView *hudView = [[UIView alloc]init];
        hudView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, 200, 30);
        CGPoint center = hudView.center;
        center.x = center.x + 50;
        label.center = center;
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor orangeColor];
        label.text = @"加载中。。。";
        hudView.hidden = YES;
        [hudView addSubview:label];
        [[UIApplication sharedApplication].keyWindow addSubview:(_hudView = hudView)];
    }
    return _hudView;
}

@end
