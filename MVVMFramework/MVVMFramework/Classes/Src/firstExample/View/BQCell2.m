//
//  BQCell2.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/5.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "BQCell2.h"
#import "BQModel.h"
@implementation BQCell2

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    BQModel *model = (BQModel *)obj ;
    self.testLabel1.text = model.title;

//    NSString *lengthStr = @"Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and apps run lightning-fast. Swift is ready for your next project — or addition into your current app — because Swift code works side-by-side with Objective-C.";
//    NSString *shortStr = @"Swift. A modern programming language that is safe, fast, and interactive.";
//    
//    self.testLabel2.text = ((indexPath.row) % 2 == 0) ? lengthStr : shortStr;
    self.testImage.image = ((indexPath.row) % 2 == 0) ? [UIImage imageNamed:@"phil"] : [UIImage imageNamed:@"dogebread"];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
