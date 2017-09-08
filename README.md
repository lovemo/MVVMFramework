![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/MVVM@2x.png)

# MVVMFramework
### Swift版本地址：https://github.com/lovemo/MVVMFramework-Swift
#### 本项目交流群：474292335
#### 欢迎有兴趣的有好的想法的参与到项目中来
###### Tip:SMKStore是在[YTKKeyValueStore](https://github.com/yuantiku/YTKKeyValueStore)的基础上直接增加了很多的相关功能函数，(偷懒:smile:)
###### 感谢[小学生](https://github.com/chouxun)提供的图标

---

##### 具体实现思路，请参看博客：
#### 博客：浅谈MVVM 
#### 地址：[点击链接进入](https://github.com/lovemo/MVVMFramework/tree/master/source)

#### [获取更多MVVM推荐文章](#Recommend)


总结整理下一个快速开发MVVM框架(抛砖引玉)，主要用于分离控制器中的代码，降低代码耦合程度，可以根据自己使用习惯调整代码。欢迎来喷，提issues。代码加入了cell自适应高度,使用SMKStore缓存数据至sqlite数据库，更加高效的数据库存储库(Tip:存储自定义模型时，为了方便，数据库存储的为其转化为json后的数据，所以当读取时，请在自行转为模型即可，<利用[MJExtension](https://github.com/CoderMJLee/MJExtension)一行代码即可>)。


#### usage:
CocoaPods：
```
	pod 'SUIMVVMKit'
```

- 详细用法，请参看demo

---

## 思维流程图示
![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/MVVMFrameWork-Thinking.png)
![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/MVVMFrameWork-Thinking2.jpeg)
## 现在的工程代码结构
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
### 部分protocol定义
```objc
@protocol SMKViewMangerProtocol <NSObject>

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

/**
 *  将model数据传递给viewManger
 */
- (void)smk_viewMangerWithModel:(NSDictionary * (^) ( ))dictBlock;

/**
 *  处理viewBlock事件
 */
- (ViewEventsBlock)smk_viewMangerWithViewEventBlockOfInfos:(NSDictionary *)infos;

/**
 *  处理ViewModelInfosBlock
 */
- (ViewModelInfosBlock)smk_viewMangerWithViewModelBlockOfInfos:(NSDictionary *)infos;

/**
 *  将viewManger中的信息通过代理传递给ViewModel
 *
 *  @param viewManger   viewManger自己
 *  @param infos 描述信息
 */
- (void)smk_viewManger:(id)viewManger withInfos:(NSDictionary *)infos;

@end

```
### Controller中的代码

```objc

- (void)viewDidLoad {
    [super viewDidLoad];

       // 将thirdView的事件处理者代理给thirdViewManger (代理方式)
    [self.thirdView smk_viewWithViewManger:self.thirdViewManger];
    
    // self.thirdView.viewEventsBlock （block方式）
    self.thirdView.viewEventsBlock = [self.thirdViewManger smk_viewMangerWithViewEventBlockOfInfos:@{@"view" : self.thirdView}];
    
    // viewManger ----> info <-----  viewModel 之间通过代理方式交互
    self.thirdViewManger.viewMangerDelegate = self.viewModel;
    self.viewModel.viewModelDelegate = self.thirdViewManger;
    
    // viewManger ----> info <-----  viewModel 之间通过block方式交互
    self.thirdViewManger.viewMangerInfosBlock = [self.viewModel smk_viewModelWithViewMangerBlockOfInfos:@{@"info" : @"viewManger"}];
    
    // 中介者传值
    SMKMediator *mediator = [SMKMediator mediatorWithViewModel:self.viewModel viewManger:self.thirdViewManger];
    
    self.thirdViewManger.smk_mediator = mediator;
    self.viewModel.smk_mediator = mediator;
    
    self.thirdViewManger.smk_viewMangerInfos = @{@"xxxxxx" : @"22222222"};
    [self.thirdViewManger smk_notice];
    NSLog(@"viewManger------>viewModel==%@", self.viewModel.smk_viewModelInfos);
    
    self.viewModel.smk_viewModelInfos = @{@"oooooo" : @"888888888"};
    [self.viewModel smk_notice];
    NSLog(@"viewModel=====>viewManger==%@", self.thirdViewManger.smk_viewMangerInfos);
}

- (IBAction)clickBtnAction:(UIButton *)sender {
    
    // thirdView 通过viewModel传递的model来配置view
    [self.thirdView smk_configureViewWithViewModel:self.viewModel];
    
}

```
### 配置ViewModel
```objc

#pragma mark 加载网络请求
- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    return [[SMKAction sharedAction] sendRequestBlock:^id<SMKRequestProtocol>{
        return [[ThirdRequest alloc]init];
    } progress:nil success:^(id responseObject) {
        NSArray *modelArray = [ThirdModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
        if (success) {
            success(modelArray);
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (id)getRandomData:(NSArray *)array {
    u_int32_t index = arc4random_uniform((u_int32_t)10);
    return array[index];
}

#pragma mark 配置加工模型数据，并通过block传递给view
- (void)smk_viewModelWithModelBlcok:(void (^)(id))modelBlock {
    [self smk_viewModelWithProgress:nil success:^(id responseObject) {
        if (modelBlock) {
            
            if (self.viewModelDelegate && [self.viewModelDelegate respondsToSelector:@selector(smk_viewModel:withInfos:)]) {
                [self.viewModelDelegate smk_viewModel:self withInfos:@{@"info" : @"呵呵， 你好， 我是ViewModel，我加载数据成功了"}];
            }
            
            modelBlock([self getRandomData:responseObject]);
        }
    } failure:nil];

}

#pragma mark ViewManger delegate
- (void)smk_viewManger:(id)viewManger withInfos:(NSDictionary *)infos  {
    NSLog(@"%@",infos);
}

#pragma mark ViewManger Block
- (ViewMangerInfosBlock)smk_viewModelWithViewMangerBlockOfInfos:(NSDictionary *)infos {
    return ^{
      NSLog(@"hello");
    };
}

```
### 配置viewManger
```objc
#pragma mark UIView的delegate方法
- (void)smk_view:(__kindof UIView *)view withEvents:(NSDictionary *)events {

    NSLog(@"----------%@", events);
    if ([[events allKeys] containsObject:@"jump"]) {
        FirstVC *firstVC = [UIViewController sui_viewControllerWithStoryboard:nil identifier:@"FirstVCID"];
        [view.sui_currentVC.navigationController pushViewController:firstVC animated:YES];
    }
    
}

#pragma mark ViewEvents Block
- (ViewEventsBlock)smk_viewMangerWithViewEventBlockOfInfos:(NSDictionary *)infos {
    
    return ^(NSString *info){
        
        if (self.viewMangerInfosBlock) {
            self.viewMangerInfosBlock();
        }
        
        if (self.viewMangerDelegate && [self.viewMangerDelegate respondsToSelector:@selector(smk_viewManger:withInfos:)]) {
            [self.viewMangerDelegate smk_viewManger:self withInfos: @{@"info" : @"哈哈，你好ViewModel，我是viewManger，我被点击了"}];
        }
        
    //    NSLog(@"%@",info);
     //   [view smk_configureViewWithModel:self.dict[@"model"]];
    };
}

#pragma mark ViewModel delegate
- (void)smk_viewModel:(id)viewModel withInfos:(NSDictionary *)infos {
    NSLog(@"%@",infos);
}
```
### 配置Request模型
```objc

- (void)smk_requestConfigures {

    self.smk_scheme = @"https";
    self.smk_host = @"api.douban.com";
    self.smk_path = @"/v2/book/search";
    self.smk_method = SMKRequestMethodGET;

}

- (id)smk_requestParameters {
    return @{@"q": @"基础"};
}

```
### SMKAction发送网络请求
```objc
- (NSURLSessionTask *)smk_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    return [[SMKAction sharedAction] sendRequestBlock:^id<SMKRequestProtocol>{
        return [[FirstRequest alloc]init];
    } progress:nil success:^(id responseObject) {
        if (responseObject) {
            NSArray *modelArray = [FirstModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
            success(modelArray);
        }
    } failure:^(NSError *error) {
        
    }];

}
    
```

### <a id="demo效果"></a> demo效果
- 只需实现加载请求以及配置自定义cell和上述代码，就能轻松实现以下效果，最重要的是代码解耦。

![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/demo.gif)

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢

## 推荐(欢迎补充)<a id="Recommend"></a>
### 应用架构文章
##### 部分来自原创微信公众平台-移动开发前线
* [Service Oriented 的 iOS 应用架构](http://www.cocoachina.com/ios/20160520/16363.html)
* [新浪微博iOS客户端架构与优化之路](http://chuansong.me/n/335912751245)
* [糯米移动组件架构演进之路](http://top.caibaojian.com/t?url=http://t.cn/RqRDJIe)
* [文化碰撞：函数式、面向协议、面向对象编程的最佳实践](https://realm.io/cn/news/tryswift-daniel-steinberg-blending-cultures/)
* [探索 Swift 中的 MVC-N 模式](https://realm.io/cn/news/slug-marcus-zarra-exploring-mvcn-swift/)
* [Code-T 沙龙资料](https://github.com/Code-T/salon-resources)
* [高速公路换轮胎——为遗留系统替换数据库](http://www.jianshu.com/p/d684693f1d77)
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
* [豆瓣混合开发实践](http://lincode.github.io/Hybrid-Rexxar)
* [滴滴出行iOS客户端架构演进之路](http://chuansong.me/n/2687514)
* [不要写死！天猫App的动态化配置中心实践 ](http://chuansong.me/n/2682208)
* [为移动应用提供离线支持](http://www.infoq.com/cn/articles/mobile-apps-offline-support)
* [携程App的网络性能优化实践](http://www.infoq.com/cn/articles/how-ctrip-improves-app-networking-performance)
* [QCon旧金山演讲总结：阿里无线技术架构演进](http://www.infoq.com/cn/articles/alibaba-mobile-infrastructure)


### MVVM学习文章
* [MVVM奇葩说](http://www.cocoachina.com/ios/20160520/16004.html)
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
