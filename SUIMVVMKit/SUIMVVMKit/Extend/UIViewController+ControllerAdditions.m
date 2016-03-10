//
//  UIViewController+ControllerAdditions.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/10.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "UIViewController+ControllerAdditions.h"
#import <objc/runtime.h>

@implementation UIViewController (ControllerAdditions)

- (NSObject *)smk_viewModel {
    NSObject *curVM = objc_getAssociatedObject(self, @selector(smk_viewModel));
    if (curVM) return curVM;
    if (![self respondsToSelector:@selector(smk_classOfViewModel)]) {
        NSException *exp = [NSException exceptionWithName:@"not found smk_classOfViewModel" reason:@"you forgot to add smk_classOfViewModel() in VC" userInfo:nil];
        [exp raise];
    }
    curVM = [[[self smk_classOfViewModel] alloc] init];
    self.smk_viewModel = curVM;
    return curVM;
}

- (void)setSmk_viewModel:(__kindof NSObject *)smk_viewModel {
    objc_setAssociatedObject(self, @selector(smk_viewModel), smk_viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSObject *)smk_viewManger {
    NSObject *curVM = objc_getAssociatedObject(self, @selector(smk_viewManger));
    if (curVM) return curVM;
    if (![self respondsToSelector:@selector(smk_classOfViewManger)]) {
        NSException *exp = [NSException exceptionWithName:@"not found smk_classOfViewManger" reason:@"you forgot to add smk_classOfViewManger() in VC" userInfo:nil];
        [exp raise];
    }
    curVM = [[[self smk_classOfViewManger] alloc] init];
    self.smk_viewManger = curVM;
    return curVM;
}

- (void)setSmk_viewManger:(__kindof NSObject *)smk_viewManger {
    objc_setAssociatedObject(self, @selector(smk_viewManger), smk_viewManger, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
