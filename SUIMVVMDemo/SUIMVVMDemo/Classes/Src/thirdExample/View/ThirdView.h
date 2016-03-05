//
//  ThirdView.h
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnClickBlock)();

@interface ThirdView : UIView

@property (nonatomic, copy) btnClickBlock btnClickBlock;

@end
