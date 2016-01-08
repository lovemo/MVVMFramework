//
//  ThirdVC.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdVC.h"
#import "FirstVC.h"
#import "ThirdViewModel.h"
#import "ThirdViewManger.h"


@interface ThirdVC ()

@property (nonatomic, strong) ThirdViewManger *thirdViewManger;
@property (nonatomic, strong) ThirdViewModel *viewModel;
@end

@implementation ThirdVC

- (ThirdViewManger *)thirdViewManger {
    if (_thirdViewManger == nil) {
        _thirdViewManger = [[ThirdViewManger alloc]init];
    }
    return _thirdViewManger;
}
- (ThirdViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[ThirdViewModel alloc]init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MVVM Example";
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc]init];
    returnButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    
    FirstVC *vc = (FirstVC *)[UIViewController viewControllerWithStoryBoardName:@"Main" identifier:@"FirstVCID"];
    __weak typeof(self) weakSelf = self;
    self.thirdViewManger.thirdView.btnJumpBlock = ^() {
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [self.view addSubview:self.thirdViewManger.thirdView];
}

- (IBAction)clickBtnAction:(UIButton *)sender {

    self.viewModel.model.name = [self.viewModel.model.name isEqualToString:@"再见"] ? @"我来了" : @"再见";
    self.thirdViewManger.viewModel = self.viewModel;
}


@end
