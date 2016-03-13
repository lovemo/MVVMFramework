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

- (void)sui_cellWillDisplayWithModel:(id)cModel indexPath:(NSIndexPath *)cIndexPath;

@end



@interface UITableViewCell (SUIHelper) <SUITableHelperProtocol>

@end

NS_ASSUME_NONNULL_END
