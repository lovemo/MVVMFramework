//
//  UITableViewCell+Extension.h
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (Extension)

+ (void)registerTable:(UICollectionView *)table
        nibIdentifier:(NSString *)identifier ;

- (void)configure:(UICollectionViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath ;

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath ;

@end
