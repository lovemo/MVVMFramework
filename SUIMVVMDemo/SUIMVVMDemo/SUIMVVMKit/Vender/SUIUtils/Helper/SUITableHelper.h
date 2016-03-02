//
//  SUITableHelper.h
//  SUIUtilsDemo
//
//  Created by RandomSuio on 16/2/20.
//  Copyright © 2016年 RandomSuio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * __nonnull (^SUITableHelperCellIdentifierBlock)(NSIndexPath *cIndexPath, id model);
typedef void (^SUITableHelperDidSelectBlock)(NSIndexPath *cIndexPath, id model);

@interface SUITableHelper : NSObject <UITableViewDataSource, UITableViewDelegate>


@property (nullable,nonatomic,copy) NSString *cellIdentifier;
- (void)cellMultipleIdentifier:(SUITableHelperCellIdentifierBlock)cb;

- (void)didSelect:(SUITableHelperDidSelectBlock)cb;

@property (nonatomic,weak) UITableView *sui_tableView;
@property (nonatomic,strong) NSIndexPath *sui_indexPath;

- (void)resetDataAry:(NSArray *)newDataAry forSection:(NSUInteger)cSection;
- (void)reloadDataAry:(NSArray *)newDataAry forSection:(NSUInteger)cSection;
- (void)addDataAry:(NSArray *)newDataAry forSection:(NSUInteger)cSection;
- (void)insertData:(id)cModel AtIndex:(NSIndexPath *)cIndexPath;
- (void)deleteDataAtIndex:(NSIndexPath *)cIndexPath;

- (id)currentModel;
- (id)currentModelAtIndexPath:(NSIndexPath *)cIndexPath;


@end

NS_ASSUME_NONNULL_END
