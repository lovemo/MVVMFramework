//
//  UITableViewCell+Extension.h
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (Extension)

/**
 *  从nib文件中根据重用标识符注册UICollectionViewcell
 */
+ (void)registerTable:(UICollectionView *)table
        nibIdentifier:(NSString *)identifier ;
/**
 *  配置UICollectionViewcell，设置UICollectionViewcell内容
 */
- (void)configure:(UICollectionViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath ;
/**
 *  获取自定义对象的cell高度
 */
+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath ;

@end
