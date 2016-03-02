//
//  UIScrollView+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/18.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIScrollView+SUIAdditions.h"
#import "UIView+SUIAdditions.h"

@implementation UIScrollView (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Content
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Content

- (CGFloat)sui_contentWidth
{
    return self.contentSize.width;
}
- (void)setSui_contentWidth:(CGFloat)sui_contentWidth
{
    CGSize curSize = self.contentSize;
    if (curSize.width != sui_contentWidth) {
        curSize.width = sui_contentWidth;
        self.contentSize = curSize;
    }
}

- (CGFloat)sui_contentHeight
{
    return self.contentSize.height;
}
- (void)setSui_contentHeight:(CGFloat)sui_contentHeight
{
    CGSize curSize = self.contentSize;
    if (curSize.height != sui_contentHeight) {
        curSize.height = sui_contentHeight;
        self.contentSize = curSize;
    }
}

- (CGFloat)sui_contentOffsetX
{
    return self.contentOffset.x;
}
- (void)setSui_contentOffsetX:(CGFloat)sui_contentOffsetX
{
    CGPoint curPoint = self.contentOffset;
    if (curPoint.x != sui_contentOffsetX) {
        curPoint.x = sui_contentOffsetX;
        self.contentOffset = curPoint;
    }
}

- (CGFloat)sui_contentOffsetY
{
    return self.contentOffset.y;
}
- (void)setSui_contentOffsetY:(CGFloat)sui_contentOffsetY
{
    CGPoint curPoint = self.contentOffset;
    if (curPoint.y != sui_contentOffsetY) {
        curPoint.y = sui_contentOffsetY;
        self.contentOffset = curPoint;
    }
}

- (CGFloat)sui_contentRealTop
{
    return -self.contentInset.top;
}
- (CGFloat)sui_contentRealBottom
{
    return self.contentSize.height + self.contentInset.bottom - self.bounds.size.height;
}
- (CGFloat)sui_contentRealLeft
{
    return -self.contentInset.left;
}
- (CGFloat)sui_contentRealRight
{
    return self.contentSize.width + self.contentInset.right - self.bounds.size.width;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Scroll
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Scroll

- (BOOL)sui_isScrollToTop
{
    return self.sui_contentOffsetY <= self.sui_contentRealTop;
}
- (BOOL)sui_isScrollToBottom
{
    return self.sui_contentOffsetY >= self.sui_contentRealBottom;
}
- (BOOL)sui_isScrollToLeft
{
    return self.sui_contentOffsetX <= self.sui_contentRealLeft;
}
- (BOOL)sui_isScrollToRight
{
    return self.sui_contentOffsetX >= self.sui_contentRealRight;
}

- (void)sui_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0, self.sui_contentRealTop) animated:animated];
}
- (void)sui_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0, self.sui_contentRealBottom) animated:animated];
}
- (void)sui_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.sui_contentRealLeft, 0) animated:animated];
}
- (void)sui_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.sui_contentRealRight, 0) animated:animated];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  PageIndex
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - PageIndex

- (NSUInteger)sui_pageIndexVartical
{
    NSUInteger curPageIndex = self.sui_contentOffsetY / self.sui_height;
    return curPageIndex;
}
- (NSUInteger)sui_pageIndexHorizontal
{
    NSUInteger curPageIndex = self.sui_contentOffsetX / self.sui_width;
    return curPageIndex;
}
- (NSUInteger)sui_pageTotalVartical
{
    NSUInteger curPageTotal = self.sui_contentHeight / self.sui_height;
    return curPageTotal;
}
- (NSUInteger)sui_pageTotalHorizontal
{
    NSUInteger curPageTotal = self.sui_contentWidth / self.sui_width;
    return curPageTotal;
}

- (void)sui_scrollToPageIndexVartical:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0, self.sui_height * pageIndex) animated:animated];
}
- (void)sui_scrollToPageIndexHorizontal:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.sui_width * pageIndex, 0) animated:animated];
}


@end
