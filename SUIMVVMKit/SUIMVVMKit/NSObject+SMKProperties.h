//
//  NSObject+SMKProperties.h
//  SMKMVVM
//
//  Created by Mac on 16/4/7.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMKViewProtocol.h"
#import "SMKViewModelProtocol.h"
#import "SMKViewMangerProtocol.h"
#import "SMKMediator.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  ViewModelBlock
 */
typedef _Nonnull id (^ViewModelBlock)( );
/**
 *  ViewMangerInfosBlock
 */
typedef void (^ViewMangerInfosBlock)( );
/**
 *  ViewModelInfosBlock
 */
typedef void (^ViewModelInfosBlock)( );




@interface NSObject (SMKProperties)

/**
 *  viewModelBlock
 */
@property (nonatomic, copy, nonnull) ViewModelBlock viewModelBlock;

/**
 *  获取一个对象的所有属性
 */
- (nullable NSDictionary *)smk_allProperties;

/**
 *  viewMangerDelegate
 */
@property (nullable, nonatomic, weak) id<SMKViewMangerProtocol> viewMangerDelegate;

/**
 *  ViewMangerInfosBlock
 */
@property (nonatomic, copy) ViewMangerInfosBlock viewMangerInfosBlock;

/**
 *  viewModelDelegate
 */
@property (nullable, nonatomic, weak) id<SMKViewModelProtocol> viewModelDelegate;

/**
 *  ViewModelInfosBlock
 */
@property (nonatomic, copy) ViewModelInfosBlock viewModelInfosBlock;

/**
 *  mediator
 */
@property (nonatomic, strong) SMKMediator *smk_mediator;

/**
 *  smk_viewMangerInfos
 */
@property (nonatomic, copy) NSDictionary *smk_viewMangerInfos;

/**
 *  smk_viewModelInfos
 */
@property (nonatomic, copy) NSDictionary *smk_viewModelInfos;

@end

NS_ASSUME_NONNULL_END