//
//  UIView+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/16.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Frame
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Frame

@property (nonatomic) CGFloat sui_x;
@property (nonatomic) CGFloat sui_y;
@property (nonatomic) CGFloat sui_width;
@property (nonatomic) CGFloat sui_height;
@property (nonatomic) CGPoint sui_origin;
@property (nonatomic) CGSize sui_size;
@property (readonly) CGFloat sui_right; // (x + width).
@property (readonly) CGFloat sui_bottom; // (y + height).
@property (nonatomic) CGFloat sui_centerX; // (x + width/2).
@property (nonatomic) CGFloat sui_centerY; // (y + height/2).


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Constraint
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Constraint

- (nullable NSLayoutConstraint *)sui_constraintTop;
- (nullable NSLayoutConstraint *)sui_constraintBottom;
- (nullable NSLayoutConstraint *)sui_constraintLeading;
- (nullable NSLayoutConstraint *)sui_constraintTrailing;
- (nullable NSLayoutConstraint *)sui_constraintWidth;
- (nullable NSLayoutConstraint *)sui_constraintHeight;
- (nullable NSLayoutConstraint *)sui_constraintCenterX;
- (nullable NSLayoutConstraint *)sui_constraintCenterY;
- (nullable NSLayoutConstraint *)sui_constraintBaseline;
- (void)sui_layoutPinnedToSuperview;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Nib
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Nib

@property (nonatomic) IBInspectable BOOL sui_loadNib;

+ (instancetype)sui_loadInstanceFromNib;
+ (instancetype)sui_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)sui_loadInstanceFromNibWithName:(NSString *)nibName owner:(nullable id)owner;
+ (instancetype)sui_loadInstanceFromNibWithName:(NSString *)nibName owner:(nullable id)owner bundle:(NSBundle *)bundle;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Layer
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Layer

@property (nonatomic) IBInspectable CGFloat sui_cornerRadius; // Defaults to zero.

@property (nonatomic) CGFloat sui_borderWidth; // Defaults to zero.
@property (nonatomic,copy) UIColor *sui_borderColor; // Defaults to opaque black.

@property (nonatomic,copy) UIColor *sui_shadowColor; // Defaults to opaque black
@property (nonatomic) CGFloat sui_shadowOpacity; // Defaults to 0. [0,1]
@property (nonatomic) CGSize sui_shadowOffset; // Defaults to (0, -3).
@property (nonatomic) CGFloat sui_shadowRadius; // Defaults to 3.
@property (nonatomic) BOOL sui_shadowPath; // Defaults to NO. When using animation set YES.


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Relationship
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Relationship

@property (nullable,readonly,copy) __kindof UIViewController *sui_currentVC;

- (nullable __kindof UIView *)sui_findSubview:(NSString *)className;
- (nullable __kindof UIView *)sui_findSupview:(NSString *)className;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  GestureRecognizer
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - GestureRecognizer

- (void)sui_addTapGes:(void (^)(UITapGestureRecognizer *cTapGes))cb;
- (void)sui_addLongPressGes:(void (^)(UILongPressGestureRecognizer *cLongPressGes))cb;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Snapshot
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Snapshot

- (nullable UIView *)sui_snapshotView:(BOOL)arterUpdates;
- (null_unspecified UIImage *)sui_snapshotImage:(BOOL)arterUpdates;
- (null_unspecified UIImage *)sui_snapshotWithRenderInContext;


@end

NS_ASSUME_NONNULL_END
