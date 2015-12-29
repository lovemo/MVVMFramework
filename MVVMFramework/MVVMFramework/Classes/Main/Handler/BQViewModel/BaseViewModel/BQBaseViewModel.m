//
//  BQBaseViewModel.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQBaseViewModel.h"

@implementation BQBaseViewModel

/**
 *  懒加载存放请求到的数据数组
 */
- (NSMutableArray *)dataArrayList {
    if (_dataArrayList == nil) {
        _dataArrayList = [NSMutableArray array];
    }
    return _dataArrayList;
}

+ (instancetype)modelWithViewController:(UIViewController *)viewController{
    BQBaseViewModel *model = self.new;
    if (model) {
        model.viewController = viewController;
    }
    return model;
}

- (NSUInteger)numberOfSections {
    return 1;
}
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    return 0;
}

- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return 0;
}

- (instancetype)modelAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

/**
 *  分离加载首页控制器内容
 */
- (void)getDataList:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure {
    
}

- (void)getDataListSuccess:(void (^)())success failure:(void (^)())failure {

}

- (NSString *)description{
    return [NSString stringWithFormat:@"View model:%@ viewController:%@",
            super.description,
            self.viewController.description
            ];
}

@end
