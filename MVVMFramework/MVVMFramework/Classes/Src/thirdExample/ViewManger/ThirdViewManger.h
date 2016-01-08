//
//  ThirdViewManger.h
//  MVVMFramework
//
//  Created by yuantao on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThirdView.h"

@class ThirdModel;

@interface ThirdViewManger : NSObject

@property (nonatomic, weak) ThirdView *thirdView;
@property (nonatomic, strong) ThirdModel *thirdModel;


@end
