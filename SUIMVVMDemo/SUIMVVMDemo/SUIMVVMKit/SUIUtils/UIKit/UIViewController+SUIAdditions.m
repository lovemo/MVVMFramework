//
//  UIViewController+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/17.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIViewController+SUIAdditions.h"
#import "SUIMacro.h"
#import "UIView+SUIAdditions.h"
#import "NSObject+SUIAdditions.h"
#import "NSString+SUIRegex.h"

@implementation UIViewController (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Relationship
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Relationship

- (NSString *)sui_identifier
{
    NSString *curIdentifier = [self sui_getAssociatedObjectWithKey:_cmd];
    if (curIdentifier) return curIdentifier;
    
    NSString *curClassName = NSStringFromClass([self class]);
    curIdentifier = [curClassName sui_regex:@"(?<=^SUI)\\S+(?=VC$)"];
    SUIAssert(curIdentifier, @"className should prefix with 'SUI' and suffix with 'VC'");
    
    if (!kNilOrNull(curClassName)) {
        [self sui_setAssociatedCopyObject:curClassName key:_cmd];
    }
    return curIdentifier;
}

- (UITableView *)sui_tableView
{
    UITableView *curTableView = [self sui_getAssociatedObjectWithKey:@selector(sui_tableView)];
    if (curTableView) return curTableView;
    
    if ([self isKindOfClass:[UITableViewController class]]) {
        curTableView = (UITableView *)self.view;
    } else {
        curTableView = [self.view sui_findSubview:@"UITableView"];
    }
    
    if (curTableView) self.sui_tableView = curTableView;
    return curTableView;
}
- (void)setSui_tableView:(UITableView *)sui_tableView
{
    sui_tableView.sui_vc = self;
    [self sui_setAssociatedRetainObject:sui_tableView key:@selector(sui_tableView)];
}

- (UIViewController *)sui_sourceVC
{
    __block UIViewController *curVC = [self sui_getAssociatedObjectWithKey:@selector(sui_sourceVC)];
    if (curVC) return curVC;
    
    if (self.navigationController) {
        __block BOOL curFlag = NO;
        [self.navigationController.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (curFlag) {
                curVC = obj;
                self.sui_sourceVC = curVC;
                *stop = YES;
            }
            if (obj == self) {
                curFlag = YES;
            }
        }];
    }
    return curVC;
}
- (void)setSui_sourceVC:(UIViewController *)sui_sourceVC
{
    [self sui_setAssociatedAssignObject:sui_sourceVC key:@selector(sui_sourceVC)];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  NavBack
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - NavBack

- (IBAction)sui_popToLastVC:(UIStoryboardSegue *)unwindSegue {}

- (IBAction)sui_backToLast
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (IBAction)sui_backToRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  StoryboardLink
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - StoryboardLink

- (void)sui_storyboardSegueWithIdentifier:(NSString *)cIdentifier
{
    [self performSegueWithIdentifier:cIdentifier sender:self];
}
- (void)sui_storyboardInstantiate:(NSString *)sui_storyboardNameAndID
{
    [self sui_storyboardInstantiate:sui_storyboardNameAndID segueType:SUISegueTypePush];
}
- (void)sui_storyboardInstantiate:(NSString *)sui_storyboardNameAndID segueType:(SUISegueType)cType
{
    NSArray *components = [sui_storyboardNameAndID componentsSeparatedByString:@"."];
    NSString *curStoryboardName = nil;
    NSString *curStoryboardID = nil;
    if (components.count == 1) {
        curStoryboardID = components[0];
    } else if (components.count > 1) {
        curStoryboardName = components[0];
        curStoryboardID = components[1];
    }
    
    UIStoryboard *curStoryboard = nil;
    if (curStoryboardName) {
        curStoryboard = gStoryboardNamed(curStoryboardName);
    } else {
        curStoryboard = self.storyboard;
    }
    [self sui_storyboardInstantiateWithStoryboard:curStoryboard storyboardID:curStoryboardID segueType:cType];
}
- (void)sui_storyboardInstantiateWithStoryboard:(UIStoryboard *)cStoryboard storyboardID:(NSString *)cStoryboardID segueType:(SUISegueType)cType
{
    UIViewController *curVC = nil;
    if (cStoryboardID) {
        curVC = [cStoryboard instantiateViewControllerWithIdentifier:cStoryboardID];
    } else {
        curVC = cStoryboard.instantiateInitialViewController;
    }
    
    if ([curVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *curNav = (UINavigationController *)curVC;
        curNav.topViewController.sui_sourceVC = self;
        [self presentViewController:curVC animated:YES completion:nil];
    } else {
        curVC.sui_sourceVC = self;
        if (cType == SUISegueTypePush) {
            [self.navigationController pushViewController:curVC animated:YES];
        } else {
            [self presentViewController:curVC animated:YES completion:nil];
        }
    }
}

__attribute__((constructor))
void sui_segue(void) {
    Class curClass = [UIViewController class];
    SEL originSel = @selector(prepareForSegue:sender:);
    SEL swizzSel = @selector(sui_prepareForSegue:sender:);
    Method originMethod = class_getInstanceMethod(curClass, originSel);
    Method swizzMthod = class_getInstanceMethod(curClass, swizzSel);
    
    BOOL didAdd = class_addMethod(curClass,
                                  originSel,
                                  method_getImplementation(swizzMthod),
                                  method_getTypeEncoding(swizzMthod));
    if (didAdd) {
        class_replaceMethod(curClass,
                            swizzSel,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzMthod);
    }
}

- (void)sui_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self sui_prepareForSegue:segue sender:sender];
    
    UIViewController *sourceVC = segue.sourceViewController;
    UIViewController *destVC = segue.destinationViewController;
    
    if ([destVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *curNav = (UINavigationController *)destVC;
        curNav.topViewController.sui_sourceVC = sourceVC;
    } else {
        destVC.sui_sourceVC = sourceVC;
        destVC.hidesBottomBarWhenPushed = YES;
    }
}

+ (UIViewController *)sui_viewControllerWithStoryboard:(nullable NSString *)storyboard identifier:(NSString *)identifier {
    NSString *storyboardName = storyboard ?: @"Main";
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}

/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Geometry
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Geometry

- (CGFloat)sui_opaqueNavBarHeight
{
    CGFloat curNavBarHeight = 0;
    UINavigationBar *curNavigationBar = self.navigationController.navigationBar;
    if (!curNavigationBar.translucent) {
        curNavBarHeight += curNavigationBar.bounds.size.height;
        if (![self prefersStatusBarHidden]) {
            curNavBarHeight += [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    return curNavBarHeight;
}
- (CGFloat)sui_translucentNavBarHeight
{
    CGFloat curNavBarHeight = 0;
    UINavigationBar *curNavigationBar = self.navigationController.navigationBar;
    if (curNavigationBar.translucent) {
        curNavBarHeight += curNavigationBar.bounds.size.height;
        if (![self prefersStatusBarHidden]) {
            curNavBarHeight += [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    return curNavBarHeight;
}

- (CGFloat)sui_opaqueTabBarHeight
{
    UITabBar *curTabBar = self.navigationController.tabBarController.tabBar;
    if (!curTabBar.translucent && ![self hidesBottomBarWhenPushed]) {
        return curTabBar.bounds.size.height;
    }
    return 0;
}
- (CGFloat)sui_translucentTabBarHeight
{
    UITabBar *curTabBar = self.navigationController.tabBarController.tabBar;
    if (curTabBar.translucent && ![self hidesBottomBarWhenPushed]) {
        return curTabBar.bounds.size.height;
    }
    return 0;
}

- (CGRect)sui_viewFrame
{
    return CGRectMake(0, 0, self.view.sui_width, kScreenHeight-self.sui_opaqueNavBarHeight-self.sui_opaqueTabBarHeight);
}


@end



/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  UITableView
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@implementation UITableView (SUIViewController)


- (UIViewController *)sui_vc
{
    UIViewController *curVC = [self sui_getAssociatedObjectWithKey:@selector(sui_vc)];
    if (curVC) return curVC;
    
    curVC = [self sui_currentVC];
    if (curVC) {
        self.sui_vc = curVC;
    }
    return curVC;
}

- (void)setSui_vc:(UIViewController *)sui_vc
{
    [self sui_setAssociatedAssignObject:sui_vc key:@selector(sui_vc)];
}


@end
