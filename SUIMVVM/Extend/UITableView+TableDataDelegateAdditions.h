//
//  UITableView+TableDataDelegateAdditions.h
//  MVVMFramework
//
//  Created by zzZ on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MVVMTableDataDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (TableDataDelegateAdditions)

@property (nullable,nonatomic,strong) MVVMTableDataDelegate *tableHander;

@end

NS_ASSUME_NONNULL_END
