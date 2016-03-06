//
//  FourthVC.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/6.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "FourthVC.h"
#import "FourthViewManger.h"
#import "FourthViewManger2.h"

@interface FourthVC ()

/** viewManger1 */
@property (nonatomic, strong) FourthViewManger *fourthViewManger1;
/** viewManger2 */
@property (nonatomic, strong) FourthViewManger2 *fourthViewManger2;

@end

@implementation FourthVC

#pragma mark lazy
- (FourthViewManger *)fourthViewManger1 {
    if (!_fourthViewManger1) {
        
        FourthViewManger *viewManger = [[FourthViewManger alloc]init];
        _fourthViewManger1 = viewManger;
        
    }
    return _fourthViewManger1;
}

#pragma mark lazy
- (FourthViewManger2 *)fourthViewManger2 {
    if (!_fourthViewManger2) {
        FourthViewManger2 *viewManger = [[FourthViewManger2 alloc]init];
        _fourthViewManger2 = viewManger;
    }
    return _fourthViewManger2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.fourthViewManger1 smk_viewMangerWithSuperView:self.view];
    [self.fourthViewManger2 smk_viewMangerWithSuperView:self.view];
    
    [self.fourthViewManger2 smk_viewMangerWithOtherSubViews:@{@"view1": [self.fourthViewManger1 smk_viewMangerOfSubView]}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.fourthViewManger1 smk_viewMangerWithLayoutSubViews:^{
        [self.fourthViewManger2 smk_viewMangerWithUpdateLayoutSubViews];
    }];
}

@end
