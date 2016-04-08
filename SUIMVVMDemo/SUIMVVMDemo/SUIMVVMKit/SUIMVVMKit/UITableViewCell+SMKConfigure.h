//
//  UITableViewCell+SMKConfigure.h
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMKViewModelProtocol.h"

@interface UITableViewCell (SMKConfigure)

/**
 *  从nib文件中根据重用标识符注册UITableViewCell
 */
+ (void)smk_registerTable:(UITableView *)table
            nibIdentifier:(NSString *)identifier;

/**
 *  从class中根据重用标识符注册UITableViewCell
 */
+ (void)smk_registerTable:(UITableView *)table
            classIdentifier:(NSString *)identifier;

/**
 *  根据model配置UITableViewCell，设置UITableViewCell内容
 */
- (void)smk_configure:(UITableViewCell *)cell
        model:(id)model
        indexPath:(NSIndexPath *)indexPath;

/**
 *  根据viewModel配置UITableViewCell，设置UITableViewCell内容
 */
- (void)smk_configure:(UITableViewCell *)cell
                viewModel:(id<SMKViewModelProtocol>)viewModel
            indexPath:(NSIndexPath *)indexPath;

/**
 *  获取自定义对象的cell高度 (已集成UITableView+FDTemplateLayoutCell，现在创建的cell自动计算高度)
 */
+ (CGFloat)smk_getCellHeightWithModel:(id)model
                            indexPath:(NSIndexPath *)indexPath ;

@end
