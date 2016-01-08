//
//  ThirdView.h
//  MVVMFramework
//
//  Created by yuantao on 16/1/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)();
typedef void(^btnJumpBlock)();

@interface ThirdView : UIView

@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (nonatomic, copy) btnClickBlock btnClickBlock;
@property (nonatomic, copy) btnJumpBlock btnJumpBlock;

@end
