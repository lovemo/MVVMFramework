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

typedef NSString * __nonnull (^SUITableHelperCellIdentifierBlock)(NSIndexPath *cIndexPath, id cModel);
typedef void (^SUITableHelperDidSelectBlock)(NSIndexPath *cIndexPath, id cModel);

@interface SUITableHelper : NSObject <UITableViewDataSource, UITableViewDelegate>


/**
 *  When using the storyboard and a single cell, set the property inspector same identifier 
 */
@property (nullable,nonatomic,copy) NSString *cellIdentifier;

/**
 *  When using xib, all incoming nib names
 */
- (void)registerNibs:(NSArray<NSString *> *)cellNibNames;

/**
 *  When there are multiple cell, returned identifier in block
 */
- (void)cellMultipleIdentifier:(SUITableHelperCellIdentifierBlock)cb;

/**
 *  If you override tableView:didSelectRowAtIndexPath: method, it will be invalid
 */
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
