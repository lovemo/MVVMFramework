//
//  UITextField+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (SUIAdditions)


@property (nonatomic) IBInspectable BOOL sui_showKeyboard;

- (void)sui_dismissKeyboard;


@end

NS_ASSUME_NONNULL_END
