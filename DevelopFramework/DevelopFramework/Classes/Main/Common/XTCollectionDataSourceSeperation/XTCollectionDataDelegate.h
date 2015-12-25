//
//  XTTableDataDelegate.h
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  配置UICollectionViewCell的内容Block
 */
typedef void (^CollectionViewCellConfigureBlock)(NSIndexPath *indexPath, id item, UICollectionViewCell *cell) ;
/**
 *  选中UICollectionViewCell的Block
 */
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UICollectionViewCell高度的Block
 */
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UICollectionViewCell大小的Block
 */
typedef CGSize (^CellItemSize)() ;
/**
 *  获取UICollectionViewCell间隔Margin的Block
 */
typedef UIEdgeInsets (^CellItemMargin)() ;



// - - - - - -- - - - - - - - -- - - - - -- -- - - - - -- 创建类 - -- - - - - -- -- - - - - -- - - - - - - - -- - - - - -- -//

@class BQBaseViewModel;
@interface XTCollectionDataDelegate : NSObject <UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  初始化方法
 */
- (id)initWithSelfFriendsDelegate:(BQBaseViewModel *)viewModel
     cellIdentifier:(NSString *)aCellIdentifier
     collectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
     configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock
     cellHeightBlock:(CellHeightBlock)aHeightBlock
     cellItemSizeBlock:(CellItemSize)cellItemSize
     cellItemMarginBlock:(CellItemMargin)cellItemMargin
     didSelectBlock:(DidSelectCellBlock)didselectBlock ;
/**
 *  设置CollectionView的Datasource和Delegate为self
 */
- (void)handleCollectionViewDatasourceAndDelegate:(UICollectionView *)collection ;
/**
 *  获取CollectionView中Item所在的indexPath
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@end
