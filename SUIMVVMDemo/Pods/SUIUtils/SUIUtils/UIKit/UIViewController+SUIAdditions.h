//
//  UIViewController+SUIAdditions.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/17.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SUISegueType) {
    SUISegueTypePush = 0,
    SUISegueTypeModal = 1
};

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Relationship
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Relationship

@property (nullable,readonly,copy) NSString *sui_identifier;
@property (nullable,nonatomic,strong) __kindof UITableView *sui_tableView;
@property (nullable,nonatomic,weak) __kindof UIViewController *sui_sourceVC;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NavBack
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - NavBack

- (IBAction)sui_backToLast;
- (IBAction)sui_backToRoot;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  StoryboardLink
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - StoryboardLink

- (void)sui_storyboardSegueWithIdentifier:(NSString *)cIdentifier;
- (void)sui_storyboardInstantiate:(NSString *)sui_storyboardNameAndID;
- (void)sui_storyboardInstantiate:(NSString *)sui_storyboardNameAndID segueType:(SUISegueType)cType;
- (void)sui_storyboardInstantiateWithStoryboard:(UIStoryboard *)cStoryboard storyboardID:(nullable NSString *)cStoryboardID segueType:(SUISegueType)cType;

- (void)sui_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

/**
 *  返回storybosrd中指定identifer的控制器
 *
 *  @param storyboardName 控制器所在的storyboard
 *  @param identifier     控制器在storyboard中指定的标识符
 *
 *  @return 指定identifer的控制器
 */
+ (__kindof UIViewController *)sui_viewControllerWithStoryboard:(NSString *)storyboard identifier:(NSString *)identifier;

/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Geometry
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Geometry

@property (readonly) CGFloat sui_opaqueNavBarHeight;
@property (readonly) CGFloat sui_translucentNavBarHeight;
@property (readonly) CGFloat sui_opaqueTabBarHeight;
@property (readonly) CGFloat sui_translucentTabBarHeight;
@property (readonly) CGRect sui_viewFrame;


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  UITableView
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@interface UITableView (SUIViewController)


@property (nullable,nonatomic,weak) UIViewController *sui_vc;


@end

NS_ASSUME_NONNULL_END
