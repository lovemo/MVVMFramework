//
//  SMKViewControllerProtocolDelegate.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/10.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#ifndef SMKViewControllerProtocolDelegate_h
#define SMKViewControllerProtocolDelegate_h
#import <UIKit/UIKit.h>

@protocol SMKViewControllerProtocolDelegate <NSObject>
@optional

- (Class)smk_classOfViewModel;

- (Class)smk_classOfViewManger;

@end

#endif /* SMKViewControllerProtocolDelegate_h */
