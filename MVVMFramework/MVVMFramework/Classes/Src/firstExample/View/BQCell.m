//
//  MyCell.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQCell.h"
#import "BQModel.h"

@implementation BQCell

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
     BQModel *model = (BQModel *)obj ;
   //  BQCell *mycell = (BQCell *)cell ;
    self.lbTitle.text = model.name ;
    
    NSString *lengthStr = @"Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and apps run lightning-fast. Swift is ready for your next project — or addition into your current app — because Swift code works side-by-side with Objective-C.";
    NSString *shortStr = @"Swift. A modern programming language that is safe, fast, and interactive.";
    
    self.lbHeight.text = ((indexPath.row) % 2 == 0) ? lengthStr : shortStr;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
