#MVVMFramework
###Swift版本地址：https://github.com/lovemo/MVVMFramework-Swift
####本项目交流群：474292335
####欢迎有兴趣的有好的想法的参与到项目中来
====
####博客：浅谈MVVM 
####地址：[点击链接进入](https://github.com/lovemo/MVVMFramework/tree/master/source)
====
再看了几篇博客后，总结整理下一个快速开发MVVM框架(抛砖引玉)，分离控制器代码，降低代码耦合

终于再也不用为ViewController中一坨坨tableView和collectionView的烦人代码忧虑了

代码加入了cell自适应高度,自动缓存网络请求至sqlite数据库，运行时自动布局UILabel，配合MJExtension，MJRefresh，AFNetworking等常用开发框架使用更佳，主要用于分离控制器中的代码，降低代码耦合程度，可以根据自己使用习惯调整代码。欢迎来喷，提issues。

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
### <a id="一句代码集成展示tableView,cell自适应高度,下拉刷新"></a> 一句代码集成展示tableView,cell自适应高度,下拉刷新

```objc
      self.table.tableHander = [[MVVMTableDataDelegate alloc]initWithViewModel:[[BQViewModel alloc]init]
                                        cellIdentifiersArray:@[MyCellIdentifier]
                                        didSelectBlock:^(NSIndexPath *indexPath, id item) {
                                                               
                                        SecondVC *vc = (SecondVC *)[UIViewController viewControllerWithStoryBoardName:@"Main" identifier:@"SecondVCID"];
                                        [weakSelf.navigationController pushViewController:vc animated:YES];
                                        NSLog(@"click row : %@",@(indexPath.row)) ;
                                        }];

```
       
### <a id="一句代码集成展示collectionView"></a> 一句代码集成展示collectionView
         
```objc
     self.collectionView.collectionHander = [[MVVMCollectionDataDelegate alloc]initWithViewModel:[[BQViewModel2 alloc]init]
                                            cellIdentifier:MyCellIdentifier
                                            collectionViewLayout:nil cellItemSizeBlock:^CGSize {
                                                return CGSizeMake(110, 120);
                                            } cellItemMarginBlock:^UIEdgeInsets {
                                                return UIEdgeInsetsMake(0, 20, 0, 20);
                                            } didSelectBlock:^(NSIndexPath *indexPath, id item) {
                                             NSString *strMsg = [NSString stringWithFormat:@"click row : %zd",indexPath.row];
                                             [[[UIAlertView alloc] initWithTitle:@"提示"
                                                                   message:strMsg
                                                                   delegate:self
                                                                   cancelButtonTitle:@"好的"
                                                                   otherButtonTitles:nil, nil] show];
                                              }];
```

### <a id="一句代码实现网络请求，自动缓存网络请求数据"></a> 一句代码实现网络请求，自动缓存网络请求数据

```objc
    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
    [MVVMHttp get:url params:nil cachePolicy:MVVMHttpReturnCacheDataThenLoad success:^(id responseObj) {
        
        NSArray *array = responseObj[@"stories"];
        self.dataArrayList = [ThirdModel mj_objectArrayWithKeyValuesArray:array];
        if (successHandler) {
            successHandler();
        }
        
    } failure:^(NSError *error) {
        
    }];
```

### <a id="几行代码实现数据存储"></a>几行代码实现数据存储

```objc
    MVVMStore *store = [[MVVMStore alloc]init];
    [store db_initWithDBName:@"demo.sqlite" tableName:@"arrarList"];
    [store db_putObject:array withId:@"arrayID" intoTable:@"arrarList"];
```

### <a id="demo效果"></a> demo效果
- 只需实现加载请求以及配置自定义cell和上述代码，就能轻松实现以下效果，最重要的是代码解耦。

![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/demo.gif)

### <a id="使用方法"></a> 使用方法
- 拖拽MVVM文件夹，然后在模块代码中新建ViewModel子类，继承MVVMBaseViewModel类型，实现加载数据等方法。
- 根据需要继承MVVMTableDataDelegate或MVVMCollectionDataDelegate扩展方法,如需显示多种cell,重写显示cell的数据源方法即可
- 在Controller中，初始化tableView或者collectionView，根据需要实现block代码，将自动根据传入的内容去展现数据。
- 利用xib自定义cell，在- (void)configure:customObj:indexPath:方法中根据模型Model内容配置cell展示的数据。

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢

## 推荐-几篇不错的MVVM学习文章
* http://www.ios122.com/tag/mvvm/
* http://ios.jobbole.com/83657/
* http://www.cocoachina.com/ios/20150525/11919.html
* http://www.cocoachina.com/ios/20140716/9152.html
* http://www.cocoachina.com/ios/20150122/10987.html
* http://bifidy.net/index.php/407
* http://www.jianshu.com/p/1e53f09d0f21
* http://www.cocoachina.com/ios/20160108/14911.html
