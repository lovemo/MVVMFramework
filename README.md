# DevelopFramework
总结整理下一个快速开发框架，分离控制器代码，降低代码耦合；

妈妈再也不用担心ViewController中一坨坨tableView和collectionView的烦人代码了

受此启发:
https://github.com/Akateason/XTTableDatasourceDelegateSeparation

进行了一些改动，并加入了阳神的cell自适应高度代码，MJExtension，MJExtension，AFNetworking等常用开发框架，主要用于分离控制器中的代码，降低代码耦合程度，可以根据自己使用习惯调整代码。

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
    
    self.tableHander = [[XTTableDataDelegate alloc] initWithItems:self.arrayList
                                                   cellIdentifier:MyCellIdentifier
                                                   configureCellBlock:configureCell
                                                   cellHeightBlock:nil
                                                   didSelectBlock:selectedBlock] ;
    
    [self.tableHander handleTableViewDatasourceAndDelegate:self.table] ;
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

    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
        [self dismissViewControllerAnimated:YES completion:nil];
    } ;
    
    CellItemSize cellItemSizeBlock = ^() {
        return CGSizeMake(120, 120);
    };
    
    CellItemMargin cellItemMarginBlock = ^() {
        return UIEdgeInsetsMake(3, 3, 3, 3);
    };
    
    self.collectionHander = [[XTCollectionDataDelegate alloc] initWithItems:self.arrayList
                                                        cellIdentifier:MyCellIdentifier
                                                        collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]
                                                        configureCellBlock:configureCell
                                                        cellHeightBlock:nil
                                                        CellItemSizeBlock:cellItemSizeBlock
                                                        CellItemMarginBlock:cellItemMarginBlock
                                                        didSelectBlock:selectedBlock] ;
    
    [self.collectionHander handleCollectionViewDatasourceAndDelegate:self.collectionView] ;
    
}

```
