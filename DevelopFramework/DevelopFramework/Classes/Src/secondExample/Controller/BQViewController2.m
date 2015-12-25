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
    
    self.collectionHander = [[XTCollectionDataDelegate alloc] initWithSelfFriendsDelegate:[[BQViewModel2 alloc]init]
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
