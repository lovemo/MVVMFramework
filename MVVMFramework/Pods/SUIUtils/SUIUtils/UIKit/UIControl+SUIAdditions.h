//
//  UIControl+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (SUIAdditions)


@property (nonatomic) BOOL sui_enabled;
@property (nonatomic) BOOL sui_selected;
@property (nonatomic) BOOL sui_highlighted;

- (void)sui_click:(void (^)(void))cb;
- (void)sui_controlEvents:(UIControlEvents)controlEvents cb:(void (^)(void))cb;


@end

NS_ASSUME_NONNULL_END
