MVVMFramework
===
再看了几篇博客后，总结整理下一个快速开发MVVM框架，分离控制器代码，降低代码耦合；
妈妈再也不用担心ViewController中一坨坨tableView和collectionView的烦人代码了

加入了cell自适应高度代码，配合MJExtension，MJExtension，AFNetworking等常用开发框架使用更佳，主要用于分离控制器中的代码，降低代码耦合程度，可以根据自己使用习惯调整代码。欢迎来喷，提issues。

##现在的代码结构
![image](https://github.com/lovemo/MVVMFramework/raw/master/MVVMFramework/MVVMFramework/screenshots/directory_tree.png)

### <a id="结构分析"></a> 结构分析

* [Common中BQViewModel抽象出的类集合](#Common)
	* [BaseViewModel 声明了一些基本的方法](#BaseViewModel)
	* [XTTableDataDelegate 遵守并实现了部分tableView的delegate和dataSource中的一些协议方法](#XTTableDataDelegate)
	* [XTCollectionDataDeleagte 遵守并实现了部分collectionView的delegate和dataSource中的一些协议方法](#XTCollectionDataDeleagte)

---

## <a id="代码分析"></a> 代码分析
### <a id="BaseViewModel"></a> BaseViewModel中代码实现

```objc
 @interface BQBaseViewModel : NSObject

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) NSMutableArray *dataArrayList;

+ (instancetype)modelWithViewController:(UIViewController *)viewController;

/**
 *  返回指定indexPath的item
 */
- (instancetype)modelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  显示多少组
 */
- (NSUInteger)numberOfSections;

/**
 *  每组中显示多少行 (用于tableView)
 */
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;

/**
 *  每组中显示多少个 (用于collectionView)
 */
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;

/**
 *  分离加载首页控制器内容
 */
- (void)getDataList:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure;
+ (void)getDataList:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure;

@end

```
       
### <a id="XTTableDataDelegate"></a> XTTableDataDelegate中代码实现
         
```objc
/**
 *  配置UITableViewCell的内容Block
 */
typedef void (^TableViewCellConfigureBlock)(NSIndexPath *indexPath, id item, UITableViewCell *cell) ;
/**
 *  选中UITableViewCell的Block
 */
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UITableViewCell高度的Block (已集成UITableView+FDTemplateLayoutCell，现在创建的cell自动计算高度)
 */
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UITableViewCell的组数 (当tableView为Group类型时设置可用)
 */
typedef NSInteger(^TableViewSectionsBlock)();


 // - - - - - -- - - - - - - - -- - - - - -- -- - - - - -- 创建类 - -- - - - - -- -- - - - - -- - - - - - - - -- - - - - -- -//

@class BQBaseViewModel;
@interface XTTableDataDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

/**
 *  设置UITableViewCell的组数 (当tableView为Group类型时设置可用)
 */
@property (nonatomic, copy) TableViewSectionsBlock tableViewSectionsBlock;

/**
 *  初始化方法
 */
- (id)initWithSelfFriendsDelegate:(BQBaseViewModel *)viewModel
     cellIdentifier:(NSString *)aCellIdentifier
     configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
     cellHeightBlock:(CellHeightBlock)aHeightBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock ;
/**
 *  设置UITableView的Datasource和Delegate为self
 */
- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table ;
/**
 *  获取UITableView中Item所在的indexPath
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@end

```

### <a id="XTCollectionDataDeleagte"></a> XTCollectionDataDeleagte中代码实现

```objc
/**
 *  配置UICollectionViewCell的内容Block
 */
typedef void (^CollectionViewCellConfigureBlock)(NSIndexPath *indexPath, id item, UICollectionViewCell *cell) ;
/**
 *  选中UICollectionViewCell的Block
 */
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UICollectionViewCell高度的Block
 */
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item) ;
/**
 *  设置UICollectionViewCell大小的Block
 */
typedef CGSize (^CellItemSize)() ;
/**
 *  获取UICollectionViewCell间隔Margin的Block
 */
typedef UIEdgeInsets (^CellItemMargin)() ;


// - - - - - -- - - - - - - - -- - - - - -- -- - - - - -- 创建类 - -- - - - - -- -- - - - - -- - - - - - - - -- - - - - -- -//

@class BQBaseViewModel;
@interface XTCollectionDataDelegate : NSObject <UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  初始化方法
 */
- (id)initWithSelfFriendsDelegate:(BQBaseViewModel *)viewModel
     cellIdentifier:(NSString *)aCellIdentifier
     collectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
     configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock
     cellHeightBlock:(CellHeightBlock)aHeightBlock
     cellItemSizeBlock:(CellItemSize)cellItemSize
     cellItemMarginBlock:(CellItemMargin)cellItemMargin
     didSelectBlock:(DidSelectCellBlock)didselectBlock ;
/**
 *  设置CollectionView的Datasource和Delegate为self
 */
- (void)handleCollectionViewDatasourceAndDelegate:(UICollectionView *)collection ;
/**
 *  获取CollectionView中Item所在的indexPath
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;

@end

```
        
* 功能模块中的类集合: 
        * Controller : 存放ViewController类资源文件
        * View : 用来呈现用户界面
        * Model : 用来呈现数据
        * ViewModel : 存放各种业务逻辑和网络请求

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
