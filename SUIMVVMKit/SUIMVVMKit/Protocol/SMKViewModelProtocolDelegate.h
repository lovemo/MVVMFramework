//
//  SMKViewModelProtocolDelegate.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/2/23.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#ifndef SMKViewModelProtocolDelegate_h
#define SMKViewModelProtocolDelegate_h

@protocol SMKViewModelProtocolDelegate <NSObject>

@optional

/**
 *  返回指定indexPath的item
 */
- (instancetype)smk_viewModelWithIndexPath:(NSIndexPath *)indexPath;

/**
 *  每组中显示多少行 (用于tableView)
 */
- (NSUInteger)smk_viewModelWithNumberOfRowsInSection:(NSUInteger)section;

/**
 *  每组中显示多少个 (用于collectionView)
 */
- (NSUInteger)smk_viewModelWithNumberOfItemsInSection:(NSUInteger)section;

@end

#endif /* SMKViewModelProtocolDelegate_h */
