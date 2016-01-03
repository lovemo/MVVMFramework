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

    // 可用自定义UICollectionViewLayout,默认为UICollectionViewFlowLayout
    self.collectionHander = [XTCollectionDataDelegate collectionWithViewModel:[[BQViewModel2 alloc]init]
                                                                                cellIdentifier:MyCellIdentifier
                                                                                collectionViewLayout:nil cellItemSizeBlock:^CGSize {
                                                                                    return CGSizeMake(110, 120);
                                                                                } cellItemMarginBlock:^UIEdgeInsets {
                                                                                    return UIEdgeInsetsMake(0, 20, 0, 20);
                                                                                } didSelectBlock:^(NSIndexPath *indexPath, id item) {
                                                                                    NSLog(@"click row : %@",@(indexPath.row)) ;
                                                                                    [self dismissViewControllerAnimated:YES completion:nil];
                                                                                }];
//    // 设置UICollectionViewCell大小
//    [self.collectionHander ItemSize:^CGSize{
//        return CGSizeMake(100, 100);
//    }];
    // 设置UICollectionView的delegate和dataSourse为collectionHander
    [self.collectionHander handleCollectionViewDatasourceAndDelegate:self.collectionView] ;

}

@end
