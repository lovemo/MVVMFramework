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
#import "UICollectionViewCell+Extension.h"
#import "BQViewModel2.h"

static NSString *const MyCellIdentifier = @"BQCollectionCell" ; // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface BQViewController2 ()

@property (nonatomic,strong) XTCollectionDataDelegate *collectionHander ;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BQViewController2

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    [self setupCollectionView];
}
/**
 *  collectionView的一些初始化工作
 */
- (void)setupCollectionView
{
    // 设置点击collectionView的每个item做的一些工作
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
        [self dismissViewControllerAnimated:YES completion:nil];
    } ;
    // 配置collectionView的每个item的size
    CellItemSize cellItemSizeBlock = ^ {
        return CGSizeMake(110, 120);
    };
    // 配置collectionView的每个item的margin
    CellItemMargin cellItemMarginBlock = ^ {
        return UIEdgeInsetsMake(0, 20, 0, 20);
    };
    // 将上述block设置给collectionHander
    self.collectionHander = [[XTCollectionDataDelegate alloc] initWithSelfFriendsDelegate:[[BQViewModel2 alloc]init]
                                                        cellIdentifier:MyCellIdentifier
                                                        collectionViewLayout: nil // 可用自定义UICollectionViewLayout,默认为UICollectionViewFlowLayout
                                                        cellItemSizeBlock:cellItemSizeBlock
                                                        cellItemMarginBlock:cellItemMarginBlock
                                                        didSelectBlock:selectedBlock] ;
    // 设置UICollectionView的delegate和dataSourse为collectionHander
    [self.collectionHander handleCollectionViewDatasourceAndDelegate:self.collectionView] ;

}

@end
