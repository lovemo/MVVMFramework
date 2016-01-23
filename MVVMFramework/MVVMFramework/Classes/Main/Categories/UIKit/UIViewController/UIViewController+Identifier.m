//
//  UIViewController+Identifier.m
//  MVVMFramework
//
//  Created by yuantao on 16/1/23.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "UIViewController+Identifier.h"
#import "NSObject+Runtime.h"

@implementation UIViewController (Identifier)

- (NSString *)vc_identifier
{
    NSString *curIdentifier = [self sui_getAssociatedObjectWithKey:@selector(vc_identifier)];
    if (curIdentifier) return curIdentifier;
    
    NSString *curClassName = NSStringFromClass([self class]);
    curIdentifier = curClassName;
    
    self.vc_identifier = curIdentifier;
    return curIdentifier;
}

- (void)setVc_identifier:(NSString *)vc_identifier
{
    [self sui_setAssociatedObject:vc_identifier key:@selector(vc_identifier) policy:OBJC_ASSOCIATION_COPY_NONATOMIC];
}



@end
