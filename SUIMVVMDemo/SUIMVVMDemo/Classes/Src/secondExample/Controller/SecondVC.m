//
//  SecondVC.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "SecondVC.h"
#import "BQCollectionCell.h"
#import "BQViewModel2.h"
#import "SUIMVVMKit.h"

static NSString *const MyCellIdentifier = @"BQCollectionCell" ; // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface SecondVC ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SecondVC

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
    self.collectionView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    self.collectionView.collectionHander = [[SMKBaseCollectionViewManger alloc]initWithViewModel:[[BQViewModel2 alloc]init]
                                                                               cellIdentifier:MyCellIdentifier
                                                                         collectionViewLayout:nil cellItemSizeBlock:^CGSize {
                                                                             return CGSizeMake(110, 120);
                                                                         } cellItemMarginBlock:^UIEdgeInsets {
                                                                             return UIEdgeInsetsMake(0, 20, 0, 20);
                                                                         } didSelectBlock:^(NSIndexPath *indexPath, id item) {
                                                                             NSString *strMsg = [NSString stringWithFormat:@"click row : %zd",indexPath.row];
                                                                             [[[UIAlertView alloc] initWithTitle:@"提示"
                                                                                                         message:strMsg
                                                                                                        delegate:self
                                                                                               cancelButtonTitle:@"好的"
                                                                                               otherButtonTitles:nil, nil] show];
                                                                         }];
}

@end
