//
//  XTTableDataDelegate.h
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void    (^CollectionViewCellConfigureBlock)(NSIndexPath *indexPath, id item, UICollectionViewCell *cell) ;
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item) ;
typedef void    (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;
typedef CGSize (^CellItemSize)() ;
typedef UIEdgeInsets (^CellItemMargin)() ;
@interface XTCollectionDataDelegate : NSObject <UICollectionViewDelegate,UICollectionViewDataSource>

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
collectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
 configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock
    cellHeightBlock:(CellHeightBlock)aHeightBlock
    CellItemSizeBlock:(CellItemSize)cellItemSize
     CellItemMarginBlock:(CellItemMargin)cellItemMargin
     didSelectBlock:(DidSelectCellBlock)didselectBlock ;

- (void)handleCollectionViewDatasourceAndDelegate:(UICollectionView *)collection ;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@end
