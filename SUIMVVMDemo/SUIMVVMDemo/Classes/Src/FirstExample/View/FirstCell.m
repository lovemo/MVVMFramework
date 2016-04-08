//
//  FirstCell.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "FirstCell.h"
#import "FirstModel.h"
#import "UITableViewCell+SMKConfigure.h"

@interface FirstCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation FirstCell

- (void)smk_configure:(UITableViewCell *)cell model:(id)model indexPath:(NSIndexPath *)indexPath {
    FirstModel *firstModel = (FirstModel *)model;
    self.titleLabel.text = firstModel.title ;
    self.summaryLabel.text = firstModel.summary;
    self.publisherLabel.text = firstModel.publisher;
    self.iconImageView.image = ((indexPath.row) % 2 == 0) ? [UIImage imageNamed:@"phil"] : [UIImage imageNamed:@"dogebread"];
}

@end
