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
typedef void (^didSelectCellBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UICollectionViewCell大小的Block
 */
typedef CGSize (^cellItemSize)() ;
/**
 *  设置UICollectionViewCell间隔Margin的Block
 */
typedef UIEdgeInsets (^cellItemMargin)() ;


 // - - - - - -- - - - - - - - - - -- 创建类 - -- - -  - - - - - -- - - - - -- -//

@class SMKBaseViewModel;
@interface SMKBaseCollectionViewManger : NSObject <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** collectionViewCell 重用标识符 */
@property (nonatomic, copy) NSString *cellIdentifier ;

/** collectionView布局方式 */
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;

/** 选中cell */
@property (nonatomic, copy) didSelectCellBlock didSelectCellBlock ;

/** cell的Size */
@property (nonatomic, copy) cellItemSize cellItemSize;

/** cell的Margin */
@property (nonatomic, copy) cellItemMargin cellItemMargin;

/** collectionView的ViewModel */
@property (nonatomic, strong) SMKBaseViewModel *viewModel;


/**
 *  设置UICollectionViewCell大小
 */
- (void)ItemSize:(cellItemSize)cellItemSize;

/**
 *  设置UICollectionViewCell间隔Margin
 */
- (void)itemInset:(cellItemMargin)cellItemMargin;

/**
 *  初始化方法
 */
- (id)initWithViewModel:(SMKBaseViewModel *)viewModel
         cellIdentifier:(NSString *)aCellIdentifier
         collectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
         cellItemSizeBlock:(cellItemSize)cellItemSize
         cellItemMarginBlock:(cellItemMargin)cellItemMargin
         didSelectBlock:(didSelectCellBlock)didselectBlock ;

/**
 *  设置CollectionView的Datasource和Delegate为self
 */
- (void)handleCollectionViewDatasourceAndDelegate:(UICollectionView *)collection ;

/**
 *  获取CollectionView中Item所在的indexPath
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@end
