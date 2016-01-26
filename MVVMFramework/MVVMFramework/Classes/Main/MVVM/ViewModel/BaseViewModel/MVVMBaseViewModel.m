//
//  MVVMBaseViewModel.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "MVVMBaseViewModel.h"

@implementation MVVMBaseViewModel

/**
 *  懒加载存放请求到的数据数组
 */
- (NSMutableArray *)dataArrayList {
    if (_dataArrayList == nil) {
        _dataArrayList = [NSMutableArray array];
    }
    return _dataArrayList;
}

+ (instancetype)vm_modelWithViewController:(UIViewController *)viewController{
    MVVMBaseViewModel *model = self.new;
    if (model) {
        model.viewController = viewController;
    }
    return model;
}

- (NSUInteger)vm_numberOfSections {
    return 1;
}
- (NSUInteger)vm_numberOfRowsInSection:(NSUInteger)section {
    return 0;
}

- (NSUInteger)vm_numberOfItemsInSection:(NSUInteger)section {
    return 0;
}

- (instancetype)vm_modelAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)vm_getDataSuccessHandler:(void (^)())successHandler {
    
}

- (NSString *)description{
    return [NSString stringWithFormat:@"View model:%@ viewController:%@",
            super.description,
            self.viewController.description
            ];
}

@end
