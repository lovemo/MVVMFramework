//
//  NSObject+SMKProperties.m
//  SMKMVVM
//
//  Created by Mac on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "NSObject+SMKProperties.h"
#import <objc/runtime.h>

@implementation NSObject (SMKProperties)

- (id<SMKViewModelProtocol>)viewModelDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setViewModelDelegate:(id<SMKViewModelProtocol>)viewModelDelegate {
    objc_setAssociatedObject(self, @selector(viewModelDelegate), viewModelDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<SMKViewMangerProtocol>)viewMangerDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setViewMangerDelegate:(id<SMKViewMangerProtocol>)viewMangerDelegate {
    objc_setAssociatedObject(self, @selector(viewMangerDelegate), viewMangerDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (ViewMangerInfosBlock)viewMangerInfosBlock {
    return objc_getAssociatedObject(self, @selector(viewMangerInfosBlock));
}

- (void)setViewMangerInfosBlock:(ViewMangerInfosBlock)viewMangerInfosBlock {
    objc_setAssociatedObject(self, @selector(viewMangerInfosBlock), viewMangerInfosBlock, OBJC_ASSOCIATION_COPY);
}

- (ViewModelInfosBlock)viewModelInfosBlock {
    return objc_getAssociatedObject(self, @selector(viewModelInfosBlock));
}

- (void)setViewModelInfosBlock:(ViewModelInfosBlock)viewModelInfosBlock {
    objc_setAssociatedObject(self, @selector(viewModelInfosBlock), viewModelInfosBlock, OBJC_ASSOCIATION_COPY);
}

- (ViewModelBlock)viewModelBlock {
    return objc_getAssociatedObject(self, @selector(viewModelBlock));
}

- (void)setViewModelBlock:(ViewModelBlock)viewModelBlock {
    objc_setAssociatedObject(self, @selector(viewModelBlock), viewModelBlock, OBJC_ASSOCIATION_COPY);
}

/**
 *  mediator
 */
- (void)setSmk_mediator:(SMKMediator *)smk_mediator {
    objc_setAssociatedObject(self, @selector(smk_mediator), smk_mediator, OBJC_ASSOCIATION_RETAIN);
}
- (SMKMediator *)smk_mediator {
    return objc_getAssociatedObject(self, @selector(smk_mediator));
}

/**
 *  smk_viewMangerInfos
 */
- (void)setSmk_viewMangerInfos:(NSDictionary *)smk_viewMangerInfos {
    objc_setAssociatedObject(self, @selector(smk_viewMangerInfos), smk_viewMangerInfos, OBJC_ASSOCIATION_COPY);
}
- (NSDictionary *)smk_viewMangerInfos {
    return objc_getAssociatedObject(self, @selector(smk_viewMangerInfos));
}

/**
 *  smk_viewModelInfos
 */
- (void)setSmk_viewModelInfos:(NSDictionary *)smk_viewModelInfos {
    objc_setAssociatedObject(self, @selector(smk_viewModelInfos), smk_viewModelInfos, OBJC_ASSOCIATION_COPY);
}
- (NSDictionary *)smk_viewModelInfos {
    return objc_getAssociatedObject(self, @selector(smk_viewModelInfos));
}

- (nullable NSDictionary *)smk_allProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for (NSUInteger i = 0; i < count; i ++) {

        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [self valueForKey:name];
        
        if (propertyValue) {
            resultDict[name] = propertyValue;
        } else {
            resultDict[name] = @"字典的key对应的value不能为nil";
        }
    }

    free(properties);
    
    return resultDict;
}

@end
