//
//  UITableView+TableDataDelegateAdditions.m
//  MVVMFramework
//
//  Created by zzZ on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "UITableView+TableDataDelegateAdditions.h"
#import "SMKBaseTableViewManger.H"
#import <objc/runtime.h>

@implementation UITableView (TableDataDelegateAdditions)

- (SMKBaseTableViewManger *)tableHander
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTableHander:(SMKBaseTableViewManger *)tableHander
{
    if (tableHander) {
        [tableHander handleTableViewDatasourceAndDelegate:self];
    }
    objc_setAssociatedObject(self, @selector(tableHander), tableHander, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


