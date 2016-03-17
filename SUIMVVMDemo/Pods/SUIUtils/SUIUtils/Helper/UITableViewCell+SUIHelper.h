//
//  UITableViewCell+SUIHelper.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/20.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SUITableHelperProtocol <NSObject>
@optional

- (void)sui_cellWillDisplayWithModel:(id)cModel;

@end


@interface UITableViewCell (SUIHelper) <SUITableHelperProtocol>


@property (nullable,nonatomic,strong) NSIndexPath *sui_indexPath;


@end

NS_ASSUME_NONNULL_END
