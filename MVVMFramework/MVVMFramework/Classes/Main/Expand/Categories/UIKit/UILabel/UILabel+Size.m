//
//  UILabel+Size.m
//  testa
//
//  Created by yuantao on 15/11/30.
//  Copyright © 2015年 yuantao. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)
- (CGSize)contentSizeWithSize:(CGSize)size {

    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font};
    
    CGSize contentSize = [self.text boundingRectWithSize:size
                                                 options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}

@end
