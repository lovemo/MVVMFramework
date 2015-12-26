MVVMFramework
===
再看了几篇博客后，总结整理下一个快速开发MVVM框架，分离控制器代码，降低代码耦合；
妈妈再也不用担心ViewController中一坨坨tableView和collectionView的烦人代码了

加入了cell自适应高度代码，配合MJExtension，MJExtension，AFNetworking等常用开发框架使用更佳，主要用于分离控制器中的代码，降低代码耦合程度，可以根据自己使用习惯调整代码。欢迎来喷，提issues。

##现在的代码结构
![image](https://github.com/lovemo/MVVMFramework/raw/master/MVVMFramework/screenshots/directory_tree.png)
## <a id="现在的创建tableView代码"></a>现在的创建tableView代码
由于用到了UITableView+FDTemplateLayoutCell，现在创建的cell自动计算高度，满足日常开发需求。
```objc
/**
 *  tableView的一些初始化工作
 */
- (void)setupTableView
{
    __weak typeof(self) weakSelf = self;
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
    
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, BQModel *obj, UITableViewCell *cell) {
        [cell configure:cell customObj:obj indexPath:indexPath] ;
    } ;

    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        [weakSelf.table deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BQViewController2 *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController2ID"];
        [weakSelf presentViewController:vc animated:YES completion:nil];
        
        LxPrintf(@"click row : %@",@(indexPath.row)) ;
    } ;
    
    self.tableHander = [[XTTableDataDelegate alloc] initWithSelfFriendsDelegate:[[BQViewModel alloc]init]
                                                 cellIdentifier:MyCellIdentifier
                                                   configureCellBlock:configureCell
                                                   cellHeightBlock:nil
                                                   didSelectBlock:selectedBlock] ;
    
    [self.tableHander handleTableViewDatasourceAndDelegate:self.table] ;
//    self.tableHander.tableViewSectionsBlock = ^ {
//        return (NSInteger)3;
//    };
}

```

## <a id="现在的创建collectionView代码"></a>现在的创建collectionView代码
```objc
/**
 *  collectionView的一些初始化工作
 */
- (void)setupCollectionView
{
    
    CollectionViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, BQTestModel *obj, UICollectionViewCell *cell) {
        [cell configure:cell customObj:obj indexPath:indexPath] ;
    } ;
//    // UICollectionView可不用实现
//    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
//        return [BQCollectionCell getCellHeightWithCustomObj:item indexPath:indexPath] ;
//    } ;
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
        [self dismissViewControllerAnimated:YES completion:nil];
    } ;

    CellItemSize cellItemSizeBlock = ^ {
        return CGSizeMake(120, 120);
    };
    
    CellItemMargin cellItemMarginBlock = ^ {
        return UIEdgeInsetsMake(3, 3, 3, 3);
    };
    
    self.collectionHander = [[XTCollectionDataDelegate alloc] initWithSelfFriendsDelegate:[[BQViewModel2 alloc]init]
                                                        cellIdentifier:MyCellIdentifier
                                                        collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]  // 可以使用自定义的UICollectionViewLayout
                                                        configureCellBlock:configureCell
                                                        cellHeightBlock:nil
                                                        cellItemSizeBlock:cellItemSizeBlock
                                                        cellItemMarginBlock:cellItemMarginBlock
                                                        didSelectBlock:selectedBlock] ;
    
    [self.collectionHander handleCollectionViewDatasourceAndDelegate:self.collectionView] ;
    
}

```
