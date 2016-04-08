//
//  FirstTableViewModel.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/8.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstTableViewModel : NSObject<UITableViewDelegate, UITableViewDataSource>

- (void)handleWithTable:(UITableView *)table;

- (void)getDataWithModelArray:(NSArray *(^)())modelArrayBlock completion:(void (^)())completion;

@end
