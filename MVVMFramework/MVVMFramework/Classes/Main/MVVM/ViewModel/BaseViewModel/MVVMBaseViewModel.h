//
//  MVVMBaseViewModel.h
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVVMBaseViewModel : NSObject

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) NSMutableArray *dataArrayList;

+ (instancetype)vm_modelWithViewController:(UIViewController *)viewController;

/**
 *  返回指定indexPath的item
 */
- (instancetype)vm_modelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  显示多少组 (当tableView为Group类型时设置可用)
 */
- (NSUInteger)vm_numberOfSections;

/**
 *  每组中显示多少行 (用于tableView)
 */
- (NSUInteger)vm_numberOfRowsInSection:(NSUInteger)section;

/**
 *  每组中显示多少个 (用于collectionView)
 */
- (NSUInteger)vm_numberOfItemsInSection:(NSUInteger)section;

/**
 *  用来判断是否加载成功,方便外部根据不同需求处理 (外部使用)
 */
- (void)vm_getDataSuccessHandler:(void (^)( ))successHandler;

@end
