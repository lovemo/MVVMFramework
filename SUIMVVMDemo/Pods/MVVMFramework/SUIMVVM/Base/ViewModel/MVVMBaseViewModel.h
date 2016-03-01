//
//  MVVMBaseViewModel.h
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMViewModelProtocol.h"

@interface MVVMBaseViewModel : NSObject <MVVMViewModelProtocol>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) NSMutableArray *dataArrayList;

+ (instancetype)vm_modelWithViewController:(UIViewController *)viewController;

/**
 *  用来判断是否加载成功,方便外部根据不同需求处理 (外部使用)
 */
- (void)vm_getDataSuccessHandler:(void (^)( ))successHandler;

@end
