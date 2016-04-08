//
//  UITableViewCell+SMKConfigure.m
//  DevelopFramework
//
//  Created by momo on 15/12/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "UITableViewCell+SMKConfigure.h"

@implementation UITableViewCell (SMKConfigure)

#pragma mark -- private
+ (UINib *)nibWithIdentifier:(NSString *)identifier
{
    return [UINib nibWithNibName:identifier bundle:nil];
}

#pragma mark - public
+ (void)smk_registerTable:(UITableView *)table
        nibIdentifier:(NSString *)identifier
{
    [table registerNib:[self nibWithIdentifier:identifier] forCellReuseIdentifier:identifier];
}
+ (void)smk_registerTable:(UITableView *)table
            classIdentifier:(NSString *)identifier
{
    [table registerClass:[self class] forCellReuseIdentifier:identifier];
}
#pragma mark --
#pragma mark - Rewrite these func in SubClass !
- (void)smk_configure:(UITableViewCell *)cell model:(id)model indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass !
}

- (void)smk_configure:(UITableViewCell *)cell viewModel:(id<SMKViewModelProtocol>)viewModel indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass !
}

+ (CGFloat)smk_getCellHeightWithModel:(id)model indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass if necessary
    if (!model) {
        return 0.0f ; // if obj is null .
    }
    return 44.0f ; // default cell height
}

@end
