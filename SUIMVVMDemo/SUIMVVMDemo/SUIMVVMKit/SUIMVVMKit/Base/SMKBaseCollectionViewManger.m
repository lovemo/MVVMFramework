//
//  SMKBaseCollectionViewManger.m
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "SMKBaseCollectionViewManger.h"
#import "UICollectionViewCell+Extension.h"

@interface SMKBaseCollectionViewManger ()
/** items */
@property (nonatomic, strong) NSArray *smk_dataArrayList;

@end

@implementation SMKBaseCollectionViewManger

- (id)initWithCellIdentifier:(NSString *)aCellIdentifier
     collectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
     cellItemSizeBlock:(CellItemSize)cellItemSize
     cellItemMarginBlock:(CellItemMargin)cellItemMargin
     didSelectBlock:(DidSelectCellBlock)didselectBlock
{
    self = [super init] ;
    if (self) {
        self.cellIdentifier = aCellIdentifier ;
        self.collectionViewLayout = collectionViewLayout == nil ? [[UICollectionViewFlowLayout alloc]init] : collectionViewLayout;
        self.cellItemSize = cellItemSize;
        self.cellItemMargin = cellItemMargin;
        self.didSelectCellBlock = didselectBlock ;
    }
    
    return self ;
}

- (void)itemSize:(CellItemSize)cellItemSize {
    self.cellItemSize = cellItemSize;
}

- (void)itemInset:(CellItemMargin)cellItemMargin {
    self.cellItemMargin = cellItemMargin;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.smk_dataArrayList[indexPath.item];
}

- (void)handleCollectionViewDatasourceAndDelegate:(UICollectionView *)collection
{
    collection.collectionViewLayout = self.collectionViewLayout;
    collection.dataSource = self ;
    collection.delegate   = self ;
}

- (void)getItemsWithModelArray:(NSArray *(^)())modelArrayBlock completion:(void (^)())completion {
    if (modelArrayBlock) {
        self.smk_dataArrayList = modelArrayBlock();
        if (completion) {
            completion();
        }
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout

// 定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellItemSize();
}

// 定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.cellItemMargin();
}

// 定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark --UICollectionViewDelegate && UICollectionViewDataSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.smk_dataArrayList.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self itemAtIndexPath:indexPath] ;

    [UICollectionViewCell registerCollect:collectionView nibIdentifier:self.cellIdentifier];
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    [cell configure:cell customObj:item indexPath:indexPath];
    return cell ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self itemAtIndexPath:indexPath] ;
    self.didSelectCellBlock(indexPath,item) ;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
