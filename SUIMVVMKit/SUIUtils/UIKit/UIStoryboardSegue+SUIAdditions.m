//
//  UIStoryboardSegue+SUIAdditions.m
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/19.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import "UIStoryboardSegue+SUIAdditions.h"
#import "SUIMacro.h"
#import <objc/runtime.h>

@implementation UIStoryboardSegue (SUIAdditions)

//
//+ (void)load
//{
//    static dispatch_once_t sui_onceToken;
//    dispatch_once(&sui_onceToken, ^{
//        
//        Method originMethod = class_getInstanceMethod([self class], @selector(perform));
//        Method swizzMthod = class_getInstanceMethod([self class], @selector(sui_perform));
//        
//        BOOL didAdd = class_addMethod([self class], @selector(perform),
//                                      method_getImplementation(swizzMthod), method_getTypeEncoding(swizzMthod));
//        
//        if (didAdd) {
//            class_replaceMethod([self class], @selector(sui_perform),
//                                method_getImplementation(originMethod),method_getTypeEncoding(originMethod));
//        } else {
//            method_exchangeImplementations(originMethod, swizzMthod);
//        }
//    });
//}
//
//- (void)sui_perform
//{
//    [self sui_perform];
//    
//    SUILogObj(self.sourceViewController);
//    SUILogObj(self.destinationViewController);
//    SUILogLine
//}


@end
