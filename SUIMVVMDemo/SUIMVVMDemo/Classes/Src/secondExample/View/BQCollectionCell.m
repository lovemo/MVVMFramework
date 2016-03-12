//
//  MyCell.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQCollectionCell.h"

@implementation BQCollectionCell

- (void)configure:(UICollectionViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    BQTestModel *myObj = (BQTestModel *)obj ;
    BQCollectionCell *mycell = (BQCollectionCell *)cell ;
    mycell.lbTitle.text = [NSString stringWithFormat:@"ID: %@",myObj.ID];
    mycell.lbHeight.text = myObj.title;
}

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.borderColor = [UIColor colorWithRed:0.461 green:0.594 blue:1.000 alpha:1.000].CGColor;
    self.layer.borderWidth = 2.0;
    self.layer.cornerRadius = 5.0;
}

@end
