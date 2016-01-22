//
//  XTTableDataDelegate.m
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTCollectionDataDelegate.h"
#import "UICollectionViewCell+Extension.h"
#import "BQBaseViewModel.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface XTCollectionDataDelegate ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSString *cellIdentifier ;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;
@property (nonatomic, copy) DidSelectCellBlock          didSelectCellBlock ;
@property (nonatomic, copy) CellItemSize cellItemSize;
@property (nonatomic, copy) CellItemMargin cellItemMargin;
@property (nonatomic, strong) BQBaseViewModel *viewModel;
@end

@implementation XTCollectionDataDelegate

- (id)initWithViewModel:(BQBaseViewModel *)viewModel
     cellIdentifier:(NSString *)aCellIdentifier
     collectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
     cellItemSizeBlock:(CellItemSize)cellItemSize
     cellItemMarginBlock:(CellItemMargin)cellItemMargin
     didSelectBlock:(DidSelectCellBlock)didselectBlock
{
    self = [super init] ;
    if (self) {
        self.viewModel = viewModel;
        self.cellIdentifier = aCellIdentifier ;
        self.collectionViewLayout = collectionViewLayout == nil ? [[UICollectionViewFlowLayout alloc]init] : collectionViewLayout;
        self.cellItemSize = cellItemSize;
        self.cellItemMargin = cellItemMargin;
        self.didSelectCellBlock = didselectBlock ;
    }
    
    return self ;
}

- (void)ItemSize:(CellItemSize)cellItemSize {
    self.cellItemSize = cellItemSize;
}

- (void)itemInset:(CellItemMargin)cellItemMargin {
    self.cellItemMargin = cellItemMargin;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.viewModel.dataArrayList[indexPath.item];
}

- (void)handleCollectionViewDatasourceAndDelegate:(UICollectionView *)collection
{
    collection.collectionViewLayout = self.collectionViewLayout;
    collection.backgroundColor = [UIColor whiteColor];
    collection.dataSource = self ;
    collection.delegate   = self ;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(collection) weakCollection = collection;
    
    [SVProgressHUD show];
    // 下拉刷新
    collection.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.viewModel getDataListSuccess:^{
                [SVProgressHUD dismiss];
                [weakCollection reloadData];
            }];
            // 结束刷新
            [weakCollection.mj_header endRefreshing];
        });
    }];
    [collection.mj_header beginRefreshing];
    collection.mj_header.automaticallyChangeAlpha = YES;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellItemSize();
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.cellItemMargin();
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark --UICollectionViewDelegate && UICollectionViewDataSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemsInSection:section];
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
