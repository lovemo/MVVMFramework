//
//  ThirdVC.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ThirdVC.h"
#import "ThirdViewModel.h"
#import "ThirdViewManger.h"
#import "FirstVC.h"

@interface ThirdVC ()

//@property (nonatomic, strong) ThirdViewManger *thirdViewManger;
//@property (nonatomic, strong) ThirdViewModel *viewModel;

@end

@implementation ThirdVC

- (Class)smk_classOfViewManger {
    return [ThirdViewManger class];
}

- (Class)smk_classOfViewModel {
    return [ThirdViewModel class];
}

//- (ThirdViewManger *)thirdViewManger {
//    if (_thirdViewManger == nil) {
//        _thirdViewManger = [[ThirdViewManger alloc]init];
//    }
//    return _thirdViewManger;
//}
//- (ThirdViewModel *)viewModel {
//    if (_viewModel == nil) {
//        _viewModel = [[ThirdViewModel alloc]init];
//    }
//    return _viewModel;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MVVM Example";

    [self.smk_viewManger smk_viewMangerWithSuperView:self.view];
    [self.smk_viewModel smk_viewModelWithGetDataSuccessHandler:nil];
}

- (IBAction)clickBtnAction:(UIButton *)sender {

    ThirdViewManger *viewManger = (ThirdViewManger *)self.smk_viewManger;
    viewManger.smk_model = [self.smk_viewModel getRandomData];
}

@end
