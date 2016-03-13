//
//  UIView+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIView+SUIAdditions.h"
#import "SUIMacro.h"
#import "NSObject+SUIAdditions.h"

@implementation UIView (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Frame
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Frame

- (CGFloat)sui_x
{
    return self.frame.origin.x;
}
- (void)setSui_x:(CGFloat)sui_x
{
    CGRect curRect = self.frame;
    if (curRect.origin.x != sui_x) {
        curRect.origin.x = sui_x;
        self.frame = curRect;
    }
}

- (CGFloat)sui_y
{
    return self.frame.origin.y;
}
- (void)setSui_y:(CGFloat)sui_y
{
    CGRect curRect = self.frame;
    if (curRect.origin.y != sui_y) {
        curRect.origin.y = sui_y;
        self.frame = curRect;
    }
}

- (CGFloat)sui_width
{
    return self.frame.size.width;
}
- (void)setSui_width:(CGFloat)sui_width
{
    CGRect curRect = self.frame;
    if (curRect.size.width != sui_width) {
        curRect.size.width = sui_width;
        self.frame = curRect;
    }
}

- (CGFloat)sui_height
{
    return self.frame.size.height;
}
- (void)setSui_height:(CGFloat)sui_height
{
    CGRect curRect = self.frame;
    if (curRect.size.height != sui_height) {
        curRect.size.height = sui_height;
        self.frame = curRect;
    }
}

- (CGPoint)sui_origin
{
    return self.frame.origin;
}
- (void)setSui_origin:(CGPoint)sui_origin
{
    CGRect curRect = self.frame;
    if (!CGPointEqualToPoint(curRect.origin, sui_origin)) {
        curRect.origin = sui_origin;
        self.frame = curRect;
    }
}

- (CGSize)sui_size
{
    return self.frame.size;
}
- (void)setSui_size:(CGSize)sui_size
{
    CGRect curRect = self.frame;
    if (!CGSizeEqualToSize(curRect.size, sui_size)) {
        curRect.size = sui_size;
        self.frame = curRect;
    }
}

- (CGFloat)sui_right
{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)sui_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)sui_centerX
{
    return CGRectGetMidX(self.frame);
}
- (void)setSui_centerX:(CGFloat)sui_centerX
{
    CGPoint curCenter = self.center;
    if (curCenter.x != sui_centerX) {
        curCenter.x = sui_centerX;
        self.center = curCenter;
    }
}
- (CGFloat)sui_centerY
{
    return CGRectGetMidY(self.frame);
}
- (void)setSui_centerY:(CGFloat)sui_centerY
{
    CGPoint curCenter = self.center;
    if (curCenter.y != sui_centerY) {
        curCenter.y = sui_centerY;
        self.center = curCenter;
    }
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Constraint
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Constraint

- (NSLayoutConstraint *)sui_constraintForAttribute:(NSLayoutAttribute)attribute
{
    NSArray *constraintArray = nil;
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    } else {
        constraintArray = [self.superview constraints];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if (fillteredArray.count) {
        NSLayoutConstraint *curConstraint = fillteredArray.firstObject;
        return curConstraint;
    }
    return nil;
}

- (NSLayoutConstraint *)sui_constraintTop
{
    return [self sui_constraintForAttribute:NSLayoutAttributeTop];
}
- (NSLayoutConstraint *)sui_constraintBottom
{
    return [self sui_constraintForAttribute:NSLayoutAttributeBottom];
}
- (NSLayoutConstraint *)sui_constraintLeading
{
    return [self sui_constraintForAttribute:NSLayoutAttributeLeft];
}
- (NSLayoutConstraint *)sui_constraintTrailing
{
    return [self sui_constraintForAttribute:NSLayoutAttributeRight];
}
- (NSLayoutConstraint *)sui_constraintWidth
{
    return [self sui_constraintForAttribute:NSLayoutAttributeWidth];
}
- (NSLayoutConstraint *)sui_constraintHeight
{
    return [self sui_constraintForAttribute:NSLayoutAttributeHeight];
}
- (NSLayoutConstraint *)sui_constraintCenterX
{
    return [self sui_constraintForAttribute:NSLayoutAttributeCenterX];
}
- (NSLayoutConstraint *)sui_constraintCenterY
{
    return [self sui_constraintForAttribute:NSLayoutAttributeCenterY];
}
- (NSLayoutConstraint *)sui_constraintBaseline
{
    return [self sui_constraintForAttribute:NSLayoutAttributeBaseline];
}
- (void)sui_layoutPinnedToSuperview
{
    SUIAssert(self.superview, @"no superview ⤭ %@ ⤪", self);
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[self]-0-|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(self)]];
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[self]-0-|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(self)]];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Nib
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Nib

- (BOOL)sui_loadNib
{
    UIView *curMainView = [self sui_mainView];
    if (!curMainView) {
        [self setSui_loadNib:YES];
    }
    return YES;
}
- (void)setSui_loadNib:(BOOL)sui_loadNib
{
    if (sui_loadNib) {
        UIView *curMainView = [self sui_mainView];
        if (!curMainView) {
            curMainView = [UIView sui_loadInstanceFromNib];
            curMainView.frame = self.bounds;
            curMainView.backgroundColor = [UIColor clearColor];
            [self setSui_mainView:curMainView];
            [self addSubview:curMainView];
            [curMainView sui_layoutPinnedToSuperview];
        }
    } else {
        [self setSui_mainView:nil];
    }
}

- (instancetype)sui_mainView
{
    return [self sui_getAssociatedObjectWithKey:@selector(sui_mainView)];
}
- (void)setSui_mainView:(UIView *)sui_mainView
{
    [self sui_setAssociatedRetainObject:sui_mainView key:@selector(sui_mainView)];
}

+ (instancetype)sui_loadInstanceFromNib
{
    return [self sui_loadInstanceFromNibWithName:gClassName(self)];
}
+ (instancetype)sui_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self sui_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)sui_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self sui_loadInstanceFromNibWithName:nibName owner:nil bundle:[NSBundle mainBundle]];
}
+ (instancetype)sui_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    NSArray *nibViews = [bundle loadNibNamed:nibName owner:owner options:nil];
    UIView *curMainView = nil;
    for (id curObj in nibViews) {
        if ([curObj isKindOfClass:[self class]]) {
            curMainView = curObj;
            break;
        }
    }
    return curMainView;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Layer
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Layer

- (CGFloat)sui_cornerRadius
{
    return self.layer.cornerRadius;
}
- (void)setSui_cornerRadius:(CGFloat)sui_cornerRadius
{
    self.layer.cornerRadius = sui_cornerRadius;
    self.layer.masksToBounds = (sui_cornerRadius > 0);
}

- (CGFloat )sui_borderWidth
{
    return self.layer.borderWidth;
}
- (void)setSui_borderWidth:(CGFloat)sui_borderWidth
{
    self.layer.borderWidth = sui_borderWidth;
}

- (UIColor *)sui_borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setSui_borderColor:(UIColor *)sui_borderColor
{
    self.layer.borderColor = [sui_borderColor CGColor];
}

- (UIColor *)sui_shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
- (void)setSui_shadowColor:(UIColor *)sui_shadowColor
{
    self.layer.shadowColor = [sui_shadowColor CGColor];
}

- (CGFloat)sui_shadowOpacity
{
    return self.layer.shadowOpacity;
}
- (void)setSui_shadowOpacity:(CGFloat)sui_shadowOpacity
{
    self.layer.shadowOpacity = sui_shadowOpacity;
}

- (CGSize)sui_shadowOffset
{
    return self.layer.shadowOffset;
}
- (void)setSui_shadowOffset:(CGSize)sui_shadowOffset
{
    self.layer.shadowOffset = sui_shadowOffset;
}

- (CGFloat)sui_shadowRadius
{
    return self.layer.shadowRadius;
}
- (void)setSui_shadowRadius:(CGFloat)sui_shadowRadius
{
    self.layer.shadowRadius = sui_shadowRadius;
}

- (BOOL)sui_shadowPath
{
    if (self.layer.shadowRadius) return YES;
    return NO;
}
- (void)setSui_shadowPath:(BOOL)sui_shadowPath
{
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.layer.bounds] CGPath];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Relationship
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Relationship

- (UIViewController *)sui_currentVC
{
    Class aClass = NSClassFromString(@"UIViewController");
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:aClass]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIView *)sui_findSubview:(NSString *)className
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(className)]) {
            return subView;
        }
    }
    return nil;
}
- (UIView *)sui_findSupview:(NSString *)className;
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIView *curView = [next superview];
        if ([curView isKindOfClass:NSClassFromString(className)]) {
            return curView;
        }
    }
    return nil;
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  GestureRecognizer
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - GestureRecognizer

- (void)sui_addTapGes:(void (^)(UITapGestureRecognizer *cTapGes))cb
{
    if (!self.userInteractionEnabled) self.userInteractionEnabled = !self.userInteractionEnabled;
    UITapGestureRecognizer *curGesture = [self sui_getAssociatedObjectWithKey:_cmd];
    if (!curGesture) {
        curGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sui_handleTapGes:)];
        [self addGestureRecognizer:curGesture];
        [self sui_setAssociatedRetainObject:curGesture key:_cmd];
    }
    [self sui_setAssociatedCopyObject:cb key:@selector(sui_handleTapGes:)];
}
- (void)sui_handleTapGes:(UITapGestureRecognizer *)tapGes
{
    void (^gesBlock)(UITapGestureRecognizer *cTapGes) = [self sui_getAssociatedObjectWithKey:_cmd];
    if (gesBlock) gesBlock(tapGes);
}

- (void)sui_addLongPressGes:(void (^)(UILongPressGestureRecognizer *cLongPressGes))cb
{
    if (!self.userInteractionEnabled) self.userInteractionEnabled = !self.userInteractionEnabled;
    UILongPressGestureRecognizer *curGesture = [self sui_getAssociatedObjectWithKey:_cmd];
    if (!curGesture) {
        curGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(sui_handleLongPressGes:)];
        [self addGestureRecognizer:curGesture];
        [self sui_setAssociatedRetainObject:curGesture key:_cmd];
    }
    [self sui_setAssociatedCopyObject:cb key:@selector(sui_handleLongPressGes:)];
}
- (void)sui_handleLongPressGes:(UILongPressGestureRecognizer *)longPressGes
{
    void (^gesBlock)(UILongPressGestureRecognizer *cLongPressGes) = [self sui_getAssociatedObjectWithKey:_cmd];
    if (gesBlock) gesBlock(longPressGes);
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Snapshot
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Snapshot

- (UIView *)sui_snapshotView:(BOOL)arterUpdates
{
    return [self snapshotViewAfterScreenUpdates:arterUpdates];
}
- (UIImage *)sui_snapshotImage:(BOOL)arterUpdates
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:arterUpdates];
    UIImage *curImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return curImage;
}
- (UIImage *)sui_snapshotWithRenderInContext
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *curImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return curImage;
}


@end
