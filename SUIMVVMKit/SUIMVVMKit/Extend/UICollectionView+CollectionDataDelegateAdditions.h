//
//  UICollectionView+CollectionDataDelegateAdditions.h
//  MVVMFramework
//
//  Created by zzZ on 16/1/8.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SMKBaseCollectionViewManger;

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (CollectionDataDelegateAdditions)

@property (nullable,nonatomic,strong) SMKBaseCollectionViewManger *collectionHander;

@end

NS_ASSUME_NONNULL_END
