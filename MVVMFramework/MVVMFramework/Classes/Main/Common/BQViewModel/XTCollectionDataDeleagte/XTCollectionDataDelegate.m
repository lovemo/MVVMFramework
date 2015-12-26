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
@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock ;
@property (nonatomic, copy) CellHeightBlock             heightConfigureBlock ;
@property (nonatomic, copy) DidSelectCellBlock          didSelectCellBlock ;
@property (nonatomic, copy) CellItemSize cellItemSize;
@property (nonatomic, copy) CellItemMargin cellItemMargin;
@property (nonatomic, strong) BQBaseViewModel *viewModel;
@end

@implementation XTCollectionDataDelegate

- (id)initWithSelfFriendsDelegate:(BQBaseViewModel *)viewModel
     cellIdentifier:(NSString *)aCellIdentifier
     collectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
     configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock
     cellHeightBlock:(CellHeightBlock)aHeightBlock
     cellItemSizeBlock:(CellItemSize)cellItemSize
     cellItemMarginBlock:(CellItemMargin)cellItemMargin
     didSelectBlock:(DidSelectCellBlock)didselectBlock
{
    self = [super init] ;
    if (self) {
        self.viewModel = viewModel;
        self.cellIdentifier = aCellIdentifier ;
        self.collectionViewLayout = collectionViewLayout;
        self.configureCellBlock = aConfigureCellBlock ;
        self.heightConfigureBlock = aHeightBlock ;
        self.cellItemSize = cellItemSize;
        self.cellItemMargin = cellItemMargin;
        self.didSelectCellBlock = didselectBlock ;
    }
    
    return self ;
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
    [self.viewModel getDataList:nil params:nil success:^(NSArray *array) {
        [SVProgressHUD dismiss];
        weakSelf.viewModel.dataArrayList = [NSMutableArray arrayWithArray:array];

       [weakCollection reloadData];
    } failure:^(NSError *error) {

    }];
    
    // 下拉刷新
    collection.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.viewModel getDataList:nil params:nil success:^(NSArray *array) {
                [SVProgressHUD dismiss];
                [weakSelf.viewModel.dataArrayList addObjectsFromArray:array];
                [weakCollection reloadData];
            } failure:^(NSError *error) {

            }];
            // 结束刷新
            [weakCollection.mj_header endRefreshing];
        });
    }];
    
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

    [UICollectionViewCell registerTable:collectionView nibIdentifier:self.cellIdentifier];
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    self.configureCellBlock(indexPath,item,cell) ;
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
