//
//  UIViewController+Identifier.h
//  MVVMFramework
//
//  Created by yuantao on 16/1/23.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Identifier)

/** 控制器标识符 */
@property (nonatomic, null_resettable, copy) NSString *vc_identifier;

@end
