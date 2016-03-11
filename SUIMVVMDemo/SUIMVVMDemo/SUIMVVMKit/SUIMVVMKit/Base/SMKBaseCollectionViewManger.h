//
//  SMKBaseCollectionViewManger.h
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionView+CollectionDataDelegateAdditions.h"

/**
 *  选中UICollectionViewCell的Block
 */
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UICollectionViewCell大小的Block
 */
typedef CGSize (^CellItemSize)() ;
/**
 *  设置UICollectionViewCell间隔Margin的Block
 */
typedef UIEdgeInsets (^CellItemMargin)() ;


 // - - - - - -- - - - - - - - - - -- 创建类 - -- - -  - - - - - -- - - - - -- -//

@interface SMKBaseCollectionViewManger : NSObject <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** collectionViewCell 重用标识符 */
@property (nonatomic, copy) NSString *cellIdentifier ;

/** collectionView布局方式 */
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;

/** 选中cell */
@property (nonatomic, copy) DidSelectCellBlock didSelectCellBlock ;

/** cell的Size */
@property (nonatomic, copy) CellItemSize cellItemSize;

/** cell的Margin */
@property (nonatomic, copy) CellItemMargin cellItemMargin;


/**
 *  设置UICollectionViewCell大小
 */
- (void)itemSize:(CellItemSize)cellItemSize;

/**
 *  设置UICollectionViewCell间隔Margin
 */
- (void)itemInset:(CellItemMargin)cellItemMargin;

/**
 *  初始化方法
 */
- (id)initWithCellIdentifier:(NSString *)aCellIdentifier
         collectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
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

/**
 *  获取模型数组
 *
 *  @param modelArrayBlock 返回模型数组Block
 *  @param completion      获取数据完成时
 */
- (void)getItemsWithModelArray:(NSArray * (^) ( ))modelArrayBlock completion:( void(^) ( ))completion;

@end
