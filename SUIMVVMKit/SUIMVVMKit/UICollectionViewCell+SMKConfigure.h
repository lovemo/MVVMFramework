//
//  UICollectionViewCell+SMKConfigure.h
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMKViewModelProtocol.h"

@interface UICollectionViewCell (SMKConfigure)

/**
 *  从nib文件中根据重用标识符注册UICollectionViewcell
 */
+ (void)smk_registerCollect:(UICollectionView *)collect
        nibIdentifier:(NSString *)identifier;

/**
 *  从class根据重用标识符注册UICollectionViewcell
 */
+ (void)smk_registerCollect:(UICollectionView *)collect
              classIdentifier:(NSString *)identifier;

/**
 *  根据model配置UICollectionViewcell，设置UICollectionViewcell内容
 */
- (void)smk_configure:(UICollectionViewCell *)cell
        model:(id)model
        indexPath:(NSIndexPath *)indexPath;

/**
 *  根据viewModel配置UICollectionViewcell，设置UICollectionViewcell内容
 */
- (void)smk_configure:(UICollectionViewCell *)cell
        viewModel:(id<SMKViewModelProtocol>)viewModel
        indexPath:(NSIndexPath *)indexPath;

/**
 *  获取自定义对象的cell高度
 */
+ (CGFloat)smk_getCellHeightWithModel:(id)model
        indexPath:(NSIndexPath *)indexPath;

@end
