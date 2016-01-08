//
//  UITableView+TableDataDelegateAdditions.m
//  MVVMFramework
//
//  Created by zzZ on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "UITableView+TableDataDelegateAdditions.h"
#import "XTableDataDelegate.h"
#import <objc/runtime.h>

@implementation UITableView (TableDataDelegateAdditions)


- (XTableDataDelegate *)tableHander
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setTableHander:(XTableDataDelegate *)tableHander
{
    if (tableHander) {
        [tableHander handleTableViewDatasourceAndDelegate:self];
    }
    objc_setAssociatedObject(self, @selector(tableHander), tableHander, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end


