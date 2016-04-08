//
//  UICollectionViewCell+SMKConfigure.m
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "UICollectionViewCell+SMKConfigure.h"

@implementation UICollectionViewCell (SMKConfigure)

#pragma mark --
+ (UINib *)nibWithIdentifier:(NSString *)identifier
{
    return [UINib nibWithNibName:identifier bundle:nil];
}

#pragma mark - Public
+ (void)smk_registerCollect:(UICollectionView *)collect
        nibIdentifier:(NSString *)identifier
{
    [collect registerNib:[self nibWithIdentifier:identifier] forCellWithReuseIdentifier:identifier];
}

+ (void)smk_registerCollect:(UICollectionView *)collect classIdentifier:(NSString *)identifier {
    [collect registerClass:[self class] forCellWithReuseIdentifier:identifier];
}

#pragma mark --
#pragma mark - Rewrite these func in SubClass !
- (void)smk_configure:(UICollectionViewCell *)cell model:(id)model indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass !
}

- (void)smk_configure:(UICollectionViewCell *)cell viewModel:(id<SMKViewModelProtocol>)viewModel indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass !
}

+ (CGFloat)smk_getCellHeightWithModel:(id)model indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass if necessary
    if (!model) {
        return 0.0f ; // if obj is null .
    }
    return 44.0f ; // default cell height
}

@end
