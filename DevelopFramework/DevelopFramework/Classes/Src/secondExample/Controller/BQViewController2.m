//
//  ViewController.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQViewController2.h"
#import "XTCollectionDataDelegate.h"
#import "BQCollectionCell.h"
#import "BQTestModel.h"
#import "BQViewModel.h"
#import "UICollectionViewCell+Extension.h"


static NSString *const MyCellIdentifier = @"BQCollectionCell" ; // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface BQViewController2 ()
@property (nonatomic, strong) NSMutableArray *arrayList ;
@property (nonatomic,strong) XTCollectionDataDelegate *collectionHander ;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BQViewController2
/**
 *  懒加载存放请求到的数据数组
 */
- (NSMutableArray *)arrayList
{
    if (_arrayList == nil) {
        _arrayList = [NSMutableArray array] ;
    }
    return _arrayList;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD show];
    [BQViewModel getViewController2DataList:nil params:nil success:^(NSArray *array) {
        [SVProgressHUD dismiss];
        self.arrayList = [NSMutableArray arrayWithArray:array];
       [self setupCollectionView] ;
       [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
    __weak typeof(self) weakSelf = self;
    // 下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [BQViewModel getHomeDataList:nil params:nil success:^(NSArray *array) {
                [SVProgressHUD dismiss];
                [weakSelf.arrayList addObjectsFromArray:array];
                [weakSelf.collectionView reloadData];
            } failure:^(NSError *error) {
                
            }];
            // 结束刷新
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
}
/**
 *  collectionView的一些初始化工作
 */
- (void)setupCollectionView
{
    
    CollectionViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, BQTestModel *obj, UICollectionViewCell *cell) {
        [cell configure:cell customObj:obj indexPath:indexPath] ;
    } ;
//    // UICollectionView可不用实现
//    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
//        return [BQCollectionCell getCellHeightWithCustomObj:item indexPath:indexPath] ;
//    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
        [self dismissViewControllerAnimated:YES completion:nil];
    } ;

    CellItemSize cellItemSizeBlock = ^ {
        return CGSizeMake(120, 120);
    };
    
    CellItemMargin cellItemMarginBlock = ^ {
        return UIEdgeInsetsMake(3, 3, 3, 3);
    };
    
    self.collectionHander = [[XTCollectionDataDelegate alloc] initWithItems:self.arrayList
                                                        cellIdentifier:MyCellIdentifier
                                                        collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]  // 可以使用自定义的UICollectionViewLayout
                                                        configureCellBlock:configureCell
                                                        cellHeightBlock:nil
                                                        cellItemSizeBlock:cellItemSizeBlock
                                                        cellItemMarginBlock:cellItemMarginBlock
                                                        didSelectBlock:selectedBlock] ;
    
    [self.collectionHander handleCollectionViewDatasourceAndDelegate:self.collectionView] ;
    
}

@end
