//
//  NSIndexPath+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (SUIAdditions)


- (instancetype)sui_previousRow;

- (instancetype)sui_nextRow;

- (instancetype)sui_previousSection;

- (instancetype)sui_nextSection;


@end

NS_ASSUME_NONNULL_END
