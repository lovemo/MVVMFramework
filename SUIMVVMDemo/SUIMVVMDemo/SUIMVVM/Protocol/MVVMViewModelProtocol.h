//
//  MVVMViewModelProtocol.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/23.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#ifndef MVVMViewModelProtocol_h
#define MVVMViewModelProtocol_h

@protocol MVVMViewModelProtocol <NSObject>

@optional

/**
 *  返回指定indexPath的item
 */
- (instancetype)vm_modelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  每组中显示多少行 (用于tableView)
 */
- (NSUInteger)vm_numberOfRowsInSection:(NSUInteger)section;

/**
 *  每组中显示多少个 (用于collectionView)
 */
- (NSUInteger)vm_numberOfItemsInSection:(NSUInteger)section;

@end

#endif /* MVVMViewModelProtocol_h */
