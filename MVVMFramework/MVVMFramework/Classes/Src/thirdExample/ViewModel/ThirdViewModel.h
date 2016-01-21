//
//  ThirdViewModel.h
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "BQMVVM.h"
#import "ThirdModel.h"

@interface ThirdViewModel : BQBaseViewModel

@property (nonatomic, strong) ThirdModel *model;

- (ThirdModel *)getRandomData;

@end
