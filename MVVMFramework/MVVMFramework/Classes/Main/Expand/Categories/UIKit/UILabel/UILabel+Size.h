//
//  UILabel+Size.h
//  testa
//
//  Created by yuantao on 15/11/30.
//  Copyright © 2015年 yuantao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Size)
/**
 *  根据UILabel文本数据计算UILabel的size
 *
 *  @param size UILabel的原来size
 *
 *  @return 计算后的UILabel的size
 */
- (CGSize)contentSizeWithSize:(CGSize)size;
@end
