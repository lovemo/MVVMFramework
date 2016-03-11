//
//  SMKBaseTableViewManger.m
//  DevelopFramework
//
//  Created by momo on 15/12/5.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "SMKBaseTableViewManger.h"
#import "UITableViewCell+Extension.h"
#import "UITableView+FDTemplateLayoutCell.h"


@interface SMKBaseTableViewManger ()
/** items */
@property (nonatomic, strong) NSArray *smk_dataArrayList;

@end

@implementation SMKBaseTableViewManger
- (NSArray *)smk_dataArrayList {
    if (_smk_dataArrayList == nil) {
        _smk_dataArrayList = [NSArray array];
    }
    return _smk_dataArrayList;
}

- (NSArray *)cellIdentifierArray {
    if (_cellIdentifierArray == nil) {
        _cellIdentifierArray = [NSArray array];
    }
    return _cellIdentifierArray;
}

- (id)initWithCellIdentifiers:(NSArray *)cellIdentifiersArray didSelectBlock:(DidSelectCellBlock)didselectBlock {
    self = [super init] ;
    if (self) {
        self.cellIdentifierArray = cellIdentifiersArray ;
        self.didSelectCellBlock = didselectBlock ;
    }
    
    return self ;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.smk_dataArrayList[indexPath.row];
}

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table
{
    
    table.dataSource = self ;
    table.delegate   = self ;
    
    [UITableViewCell registerTable:table nibIdentifier:self.cellIdentifierArray[0]] ;
    table.tableFooterView = [UIView new];
}

- (void)getItemsWithModelArray:(NSArray *(^)())modelArrayBlock completion:(void (^)())completion{
    if (modelArrayBlock) {
        self.smk_dataArrayList = modelArrayBlock();
        if (completion) {
            completion();
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.smk_dataArrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifierArray[0] forIndexPath:indexPath] ;
    
    [cell configure:cell customObj:item indexPath:indexPath];
    //  self.configureCellBlock(indexPath,item,cell) ;
    return cell ;
 
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    __weak typeof(self) weakSelf = self;
    
    return [tableView fd_heightForCellWithIdentifier:weakSelf.cellIdentifierArray[0] cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        [cell configure:cell customObj:item indexPath:indexPath];
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id item = [self itemAtIndexPath:indexPath] ;
    self.didSelectCellBlock(indexPath,item) ;
}

@end
