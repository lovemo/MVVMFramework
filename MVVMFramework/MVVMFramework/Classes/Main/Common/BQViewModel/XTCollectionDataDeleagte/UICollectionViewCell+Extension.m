//
//  UITableViewCell+Extension.m
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "UICollectionViewCell+Extension.h"

@implementation UICollectionViewCell (Extension)

#pragma mark --
+ (UINib *)nibWithIdentifier:(NSString *)identifier
{
    return [UINib nibWithNibName:identifier bundle:nil];
}

#pragma mark - Public
+ (void)registerTable:(UICollectionView *)table
        nibIdentifier:(NSString *)identifier
{
    [table registerNib:[self nibWithIdentifier:identifier] forCellWithReuseIdentifier:identifier];
  
}

#pragma mark --
#pragma mark - Rewrite these func in SubClass !
- (void)configure:(UICollectionViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass !
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass if necessary
    if (!obj) {
        return 0.0f ; // if obj is null .
    }
    return 44.0f ; // default cell height
}

@end
