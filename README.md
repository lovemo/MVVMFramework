#MVVMFramework
###Swift版本地址：https://github.com/lovemo/MVVMFramework-Swift
####本项目交流群：474292335
####欢迎有兴趣的有好的想法的参与到项目中来
====
#####具体实现思路，请参看博客：
####博客：浅谈MVVM 
####地址：[点击链接进入](https://github.com/lovemo/MVVMFramework/tree/master/source)
====

总结整理下一个快速开发MVVM框架(抛砖引玉)，主要用于分离控制器中的代码，降低代码耦合程度，可以根据自己使用习惯调整代码。欢迎来喷，提issues。代码加入了cell自适应高度,自动缓存网络请求至sqlite数据库，更加高效的数据库存储库。

====
####usage:
CocoaPods：
```
	pod 'SUIMVVMKit'
```

- 根据需要继承SMKBaseTableViewManger或SMKBaseCollectionViewManger扩展方法,如需显示多种cell,重写显示cell的数据源方法即可
- 在Controller中，初始化tableView或者collectionView，根据需要实现block代码，将自动根据传入的内容去展现数据。
- 利用xib自定义cell，在- (void)configure:customObj:indexPath:方法中根据模型Model内容配置cell展示的数据。


====
##思维流程图示
![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/MVVMFrameWork-Thinking.png)
![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/MVVMFrameWork-Thinking2.jpeg)
##现在的工程代码结构
![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/directory_tree.png)

### <a id="模块构建"></a> 模块构建
  
* [功能模块中的类集合](#Examples)
	* [Controller - 负责ViewManger和ViewModel之间的绑定，另一方面也负责常规的UI逻辑处理。](#JSON_Model)
	* [View - 用来呈现用户界面](#JSONString_Model)
	* [ViewManger - 用来处理View的常规事件](#Model_contains_model_array)
	* [Model - 用来呈现数据](#Model_contains_model)
	* [ViewModel - 存放各种业务逻辑和网络请求](#Model_contains_model_array)


---

### <a id="结构分析"></a> 结构分析
* [MVVM中模块的集合](#MVVM)
	* [Handler 负责处理实现tableView和collectionView的delegate和dataSource中的一些协议方法](#Handler)
	* [Network 实现常用的网络请求代码](#Network)
	* [Base 一些基础模块](#Base)
	* [Extend 扩展系统功能模块](#Extend)
	* [Store 实现常用的数据存储方法](#Store)
	* [ViewModel 声明了一些基本的方法,负责处理一些系统业务逻辑](#ViewModel)
	* [Vender 一些依赖库](#Vender)

---

## <a id="代码示例"></a> 代码示例
###部分protocol定义
```objc
@protocol SMKViewMangerProtocolDelegate <NSObject>

@optional

/**
 *  设置Controller的子视图的管理者为self
 *
 *  @param superView 一般指subView所在控制器的view
 */
- (void)smk_viewMangerWithSuperView:(UIView *)superView;

/**
 *  设置subView的管理者为self
 *
 *  @param subView 管理的subView
 */
- (void)smk_viewMangerWithSubView:(UIView *)subView;

/**
 *  设置添加subView的事件
 *
 *  @param view 管理的subView
 *  @param info 附带信息，用于区分调用
 */
- (void)smk_viewMangerWithHandleOfSubView:(UIView *)subView info:(NSString *)info;

/**
 *  返回viewManger所管理的视图
 *
 *  @return viewManger所管理的视图
 */
- (__kindof UIView *)smk_viewMangerOfSubView;

/**
 *  得到其它viewManger所管理的subView，用于自己内部
 *
 *  @param views 其它的subViews
 */
- (void)smk_viewMangerWithOtherSubViews:(NSDictionary *)viewInfos;

/**
 *  需要重新布局subView时，更改subView的frame或者约束
 *
 *  @param block 更新布局完成的block
 */
- (void)smk_viewMangerWithLayoutSubViews:(void (^)( ))updateBlock;

/**
 *  使子视图更新到最新的布局约束或者frame
 */
- (void)smk_viewMangerWithUpdateLayoutSubViews;

@end
```
###配置代码集成展示tableView,cell自适应高度

```objc
/**
 *  tableView的一些初始化工作
 */
- (void)setupTableView
{

    self.table.separatorStyle = UITableViewCellSelectionStyleNone;

    __weak typeof(self) weakSelf = self;
    __weak typeof(self.table) weakTable = self.table;
    
    // 下拉刷新
    self.table.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.viewModel smk_viewModelWithGetDataSuccessHandler:^(NSArray *array) {
            [weakTable reloadData];
        }];
        // 结束刷新
        [weakTable.mj_header endRefreshing];
    }];
    
    [self.table.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.table.mj_header.automaticallyChangeAlpha = YES;
    
    self.table.tableHander = [[TestViewDelegate alloc]initWithCellIdentifiers:@[MyCellIdentifier] didSelectBlock:^(NSIndexPath *indexPath, id item) {
        SecondVC *vc = (SecondVC *)[UIViewController svv_viewControllerWithStoryBoardName:@"Main" identifier:@"SecondVCID"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        NSLog(@"click row : %@",@(indexPath.row)) ;
    }];

    [self.viewModel smk_viewModelWithGetDataSuccessHandler:^(NSArray *array){
        [self.table.tableHander getItemsWithModelArray:^NSArray *{
            return array;
        } completion:^{
            [self.table reloadData];
        }];
    }];

}

```
       
###配置代码集成展示collectionView
         
```objc
/**
 *  collectionView的一些初始化工作
 */
- (void)setupCollectionView
{

    // 可用自定义UICollectionViewLayout,默认为UICollectionViewFlowLayout
    self.collectionView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.collectionHander = [[SMKBaseCollectionViewManger alloc]initWithCellIdentifier:MyCellIdentifier collectionViewLayout:nil cellItemSizeBlock:^CGSize{
        return CGSizeMake(110, 120);
    } cellItemMarginBlock:^UIEdgeInsets{
        return UIEdgeInsetsMake(0, 20, 0, 20);
    } didSelectBlock:^(NSIndexPath *indexPath, id item) {
        NSString *strMsg = [NSString stringWithFormat:@"click row : %zd",indexPath.row];
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:strMsg
                                   delegate:self
                          cancelButtonTitle:@"好的"
                          otherButtonTitles:nil, nil] show];
    }];
    
    [self.viewModel smk_viewModelWithGetDataSuccessHandler:^(NSArray *array) {
      [self.collectionView.collectionHander getItemsWithModelArray:^NSArray *{
          return array;
      } completion:^{
          [self.collectionView reloadData];
      }];
    }];

}
```
###配置viewManger
```objc
// UIView的delegate方法 ，两种消息传递方式，开发时任选其一即可 根据传入的events信息处理事件
- (void)smk_view:(__kindof UIView *)view withEvents:(NSDictionary *)events {

    NSLog(@"----------%@", events);
    
    if ([[events allKeys] containsObject:@"jump"]) {
        FirstVC *firstVC = [UIViewController svv_viewControllerWithStoryBoardName:@"Main" identifier:@"FirstVCID"];
        [view.sui_currentVC.navigationController pushViewController:firstVC animated:YES];
    }
    
}

// 得到父视图，添加subView -> superView
- (void)smk_viewMangerWithSuperView:(UIView *)superView {
    self.thirdView.frame = CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, 200);
    [superView addSubview:self.thirdView];
}

// 根据传入的info设置添加subView的事件
- (void)smk_viewMangerWithHandleOfSubView:(UIView *)view info:(NSString *)info {
    
    if ([info isEqualToString:@"click"]) {
        [view configureViewWithCustomObj:self.dict[@"model"]];
    }
}
// 得到模型数据
- (void)viewMangerWithModel:(NSDictionary *(^)( ))dictBlock {
    if (dictBlock) {
        self.dict = dictBlock();
    }
}
```

###一句代码实现网络请求，自动缓存网络请求数据
#####具体实现细节，[点击进入查看SUIMVVMNetwork](https://github.com/lovemo/SUIMVVMNetwork)

```objc
- (void)smk_viewModelWithGetDataSuccessHandler:(void (^)(NSArray *))successHandler {
    
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    [SMKHttp get:url params:nil cachePolicy:SMKHttpReturnCacheDataThenLoad success:^(id responseObj) {
        
        NSArray *array = responseObj[@"stories"];
        self.smk_dataArrayList = [ThirdModel mj_objectArrayWithKeyValuesArray:array];
        if (successHandler) {
            successHandler(self.smk_dataArrayList);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
    
```

### <a id="几行代码实现数据存储"></a>几行代码实现数据存储
#####具体实现细节，[点击进入查看SUIMVVMStore](https://github.com/lovemo/SUIMVVMStore)
```objc
    static NSString *tableName = @"arrarList";

    SMKStore *store = [SMKStore sharedStore];
    [store db_initWithDBName:@"demo.sqlite" tableName:tableName];
    [store db_putObject:array withId:@"arrayID" intoTable:tableName];
```

### <a id="demo效果"></a> demo效果
- 只需实现加载请求以及配置自定义cell和上述代码，就能轻松实现以下效果，最重要的是代码解耦。

![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/demo.gif)

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢

## 推荐
###应用架构文章
* [围观神仙打架，反革命工程师《iOS应用架构谈 组件化方案》和蘑菇街Limboy的《蘑菇街 App 的组件化之路》的阅读指导](http://reviewcode.cn/article.html?reviewId=20)
* [iOS 组件化方案探索](http://blog.cnbang.net/tech/3080/)
* [iOS应用架构谈 组件化方案 ](http://casatwy.com/iOS-Modulization.html)
* [解耦神器 —— 统跳协议和Rewrite引擎](http://pingguohe.net/2015/11/24/Navigator-and-Rewrite.html)
* [携程移动App架构优化之旅 ](https://mp.weixin.qq.com/s?__biz=MzA3ODg4MDk0Ng==&mid=403009403&idx=1&sn=d19264fa1d06b9c5a9dfb1d192a0ed8e&scene=1&srcid=0401q08nZugjahvHG8rIXA3D&key=710a5d99946419d9421e8fbc5fb565c3a91aaaba22b5db9dffc9bcfae33aa18f533fbe82c6c570fec3720d82be5b9b5a&ascene=0&uin=MTMzODgyNTU%3D&devicetype=iMac+MacBookPro10%2C1+OSX+OSX+10.11+build%2815A282b%29&version=11000004&pass_ticket=IbzhLj2Kxa98XTnVDWywF6o6dyAlCik592Btwh3yT4A%3D)
* [蘑菇街App的组件化之路](#蘑菇街App的组件化之路)
	* [蘑菇街App的组件化之路(微信文章)](https://mp.weixin.qq.com/s?__biz=MzA3ODg4MDk0Ng==&mid=402696366&idx=1&sn=ba8cbd75849b9657175c4b25bb0ac5b5&scene=1&srcid=0401oAmP7sfKiXI2di3pJuOk&key=710a5d99946419d91e680351171de6fada2f6c71eaae2e235c5d4c37c97363d6a9d3cd45dd9ab9cdcccf2a0e701d01c5&ascene=0&uin=MTMzODgyNTU%3D&devicetype=iMac+MacBookPro10%2C1+OSX+OSX+10.11+build%2815A282b%29&version=11000004&pass_ticket=IbzhLj2Kxa98XTnVDWywF6o6dyAlCik592Btwh3yT4A%3D)
	* [蘑菇街App的组件化之路(博客文章)](http://limboy.me/ios/2016/03/10/mgj-components.html?utm_source=tuicool&utm_medium=referral)
* [蘑菇街 App 的组件化之路·续](http://limboy.me/ios/2016/03/14/mgj-components-continued.html)
* [猿题库 iOS 客户端架构设计](http://gracelancy.com/blog/2016/01/06/ape-ios-arch-design/)

###MVVM学习文章
* [面向协议的 MVVM 架构介绍](https://realm.io/cn/news/doios-natasha-murashev-protocol-oriented-mvvm/)
* [MVVM With ReactiveCocoa](http://www.cocoachina.com/ios/20160330/15823.html)
* [#1 更轻量的 View Controllers](http://objccn.io/issue-1/)
* [ReactiveCocoa 和 MVVM 入门](http://yulingtianxia.com/blog/2015/05/21/ReactiveCocoa-and-MVVM-an-Introduction/)
* [MVVM 介绍](http://objccn.io/issue-13-1/)
* [写给iOS小白的MVVM教程(序)](http://www.ios122.com/2015/10/mvvm_start/)
* [多方位全面解析：如何正确地写好一个界面](http://ios.jobbole.com/83657/)
* [iOS应用架构谈 view层的组织和调用方案](http://www.cocoachina.com/ios/20150525/11919.html)
* [用Model-View-ViewModel构建iOS App](http://www.cocoachina.com/ios/20140716/9152.html)
* [浅谈iOS中MVVM的架构设计与团队协作](http://www.cocoachina.com/ios/20150122/10987.html)
* [一次简单的 ViewModel 实践](http://bifidy.net/index.php/407)
* [不要把ViewController变成处理tableView的"垃圾桶"](http://www.cocoachina.com/ios/20151218/14743.html)
* [实践干货！猿题库 iOS 客户端架构设计](http://www.cocoachina.com/ios/20160108/14911.html)
