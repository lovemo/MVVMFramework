//
//  UILabel+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UILabel+SUIAdditions.h"
#import "NSString+SUIAdditions.h"
#import "UIView+SUIAdditions.h"

@implementation UILabel (SUIAdditions)


- (CGFloat)sui_calculateHeight
{
    return [self.text sui_heightWithFont:self.font constrainedToWidth:self.sui_width];
}

- (CGSize)sui_calculateSize
{
    return [self.text sui_sizeWithFont:self.font constrainedToWidth:self.sui_width];
}


@end
