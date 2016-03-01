//
//  UIScrollView+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Content
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Content

@property (nonatomic) CGFloat sui_contentWidth;
@property (nonatomic) CGFloat sui_contentHeight;
@property (nonatomic) CGFloat sui_contentOffsetX;
@property (nonatomic) CGFloat sui_contentOffsetY;

@property (readonly) CGFloat sui_contentRealTop;
@property (readonly) CGFloat sui_contentRealBottom;
@property (readonly) CGFloat sui_contentRealLeft;
@property (readonly) CGFloat sui_contentRealRight;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Scroll
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Scroll

@property (readonly) BOOL sui_isScrollToTop;
@property (readonly) BOOL sui_isScrollToBottom;
@property (readonly) BOOL sui_isScrollToLeft;
@property (readonly) BOOL sui_isScrollToRight;

- (void)sui_scrollToTopAnimated:(BOOL)animated;
- (void)sui_scrollToBottomAnimated:(BOOL)animated;
- (void)sui_scrollToLeftAnimated:(BOOL)animated;
- (void)sui_scrollToRightAnimated:(BOOL)animated;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  PageIndex
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - PageIndex

@property (readonly) NSUInteger sui_pageIndexVartical;
@property (readonly) NSUInteger sui_pageIndexHorizontal;
@property (readonly) NSUInteger sui_pageTotalVartical;
@property (readonly) NSUInteger sui_pageTotalHorizontal;

- (void)sui_scrollToPageIndexVartical:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)sui_scrollToPageIndexHorizontal:(NSUInteger)pageIndex animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
