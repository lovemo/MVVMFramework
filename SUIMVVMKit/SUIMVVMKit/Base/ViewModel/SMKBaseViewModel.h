//
//  SMKBaseViewModel.h
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMKViewModelProtocolDelegate.h"

@interface SMKBaseViewModel : NSObject <SMKViewModelProtocolDelegate>

@property (nonatomic, weak) UIViewController *smk_viewController;
@property (nonatomic, strong) NSMutableArray *smk_dataArrayList;

+ (instancetype)smk_viewModelWithViewController:(UIViewController *)viewController;

/**
 *  用来判断是否加载成功,方便外部根据不同需求处理 (外部使用)
 */
- (void)smk_viewModelWithGetDataSuccessHandler:(void (^)( ))successHandler;

@end
