//
//  SMKBaseViewModel.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "SMKBaseViewModel.h"

@implementation SMKBaseViewModel

/**
 *  懒加载存放请求到的数据数组
 */
- (NSMutableArray *)smk_dataArrayList {
    if (_smk_dataArrayList == nil) {
        _smk_dataArrayList = [NSMutableArray array];
    }
    return _smk_dataArrayList;
}

+ (instancetype)smk_viewModelWithViewController:(UIViewController *)viewController{
    SMKBaseViewModel *model = self.new;
    if (model) {
        model.smk_viewController = viewController;
    }
    return model;
}

- (void)smk_viewModelWithGetDataSuccessHandler:(void (^)())successHandler {
    
}

- (NSString *)description{
    return [NSString stringWithFormat:@"View model:%@ viewController:%@",
            super.description,
            self.smk_viewController.description
            ];
}

@end
