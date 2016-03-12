//
//  MyCell.h
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BQCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbHeight;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;

@end
