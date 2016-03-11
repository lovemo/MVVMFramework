//
//  SMKBaseTableViewManger.h
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+TableDataDelegateAdditions.h"

/**
 *  选中UITableViewCell的Block
 */
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;

 // - - - - - -- - - - - - - - - - -- 创建类 - -- - -  - - - - - -- - - - - -- -//

@interface SMKBaseTableViewManger : NSObject <UITableViewDelegate,UITableViewDataSource>

/** cell的可重用标识符 <如需显示多种cell，需继承此类，重写显示cell的数据源方法> */
@property (nonatomic, copy) NSArray *cellIdentifierArray ;

/** 选中cell */
@property (nonatomic, copy) DidSelectCellBlock didSelectCellBlock ;

/**
 *  初始化方法
 */
- (id)initWithCellIdentifiers:(NSArray *)cellIdentifiersArray
        didSelectBlock:(DidSelectCellBlock)didselectBlock ;

/**
 *  设置UITableView的Datasource和Delegate为self
 */
- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table ;

/**
 *  获取UITableView中Item所在的indexPath
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

/**
 *  获取模型数组
 *
 *  @param modelArrayBlock 返回模型数组Block
 *  @param completion      获取数据完成时
 */
- (void)getItemsWithModelArray:(NSArray * (^) ( ))modelArrayBlock completion:( void(^) ( ))completion;


@end
