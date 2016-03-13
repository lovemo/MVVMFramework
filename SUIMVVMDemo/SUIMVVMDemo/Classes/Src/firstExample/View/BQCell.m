//
//  MyCell.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "BQCell.h"
#import "FirstModel.h"

@implementation BQCell

//- (void)configure:(UITableViewCell *)cell
//        customObj:(id)obj
//        indexPath:(NSIndexPath *)indexPath
//{
//     FirstModel *model = (FirstModel *)obj ;
//   //  BQCell *mycell = (BQCell *)cell ;
//    self.lbTitle.text = model.title ;
//    
//    NSString *lengthStr = @"Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and apps run lightning-fast. Swift is ready for your next project — or addition into your current app — because Swift code works side-by-side with Objective-C.";
//    NSString *shortStr = @"Swift. A modern programming language that is safe, fast, and interactive.";
//    
//    self.lbHeight.text = ((indexPath.row) % 2 == 0) ? lengthStr : shortStr;
//    self.contentImage.image = ((indexPath.row) % 2 == 0) ? [UIImage imageNamed:@"phil"] : [UIImage imageNamed:@"dogebread"];
//}


- (void)sui_cellWillDisplayWithModel:(id)cModel indexPath:(NSIndexPath *)cIndexPath
{
    FirstModel *model = (FirstModel *)cModel ;
    self.lbTitle.text = model.title ;
    
    NSString *lengthStr = @"Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and apps run lightning-fast. Swift is ready for your next project — or addition into your current app — because Swift code works side-by-side with Objective-C.";
    NSString *shortStr = @"Swift. A modern programming language that is safe, fast, and interactive.";
    
    self.lbHeight.text = ((cIndexPath.row) % 2 == 0) ? lengthStr : shortStr;
    self.contentImage.image = ((cIndexPath.row) % 2 == 0) ? [UIImage imageNamed:@"phil"] : [UIImage imageNamed:@"dogebread"];
}


- (void)awakeFromNib {
    // Initialization code
}

@end
