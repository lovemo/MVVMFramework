#浅谈MVVM

&emsp;&emsp;做iOS开发也有一段时间了，最近闲暇之余学习研究了下MVVM，每个人对架构和设计模式都有不同的理解，在此记录下我对MVVM的一些小见解，仅供参考，欢迎批评指正。

##概述
[引用iOS应用架构谈](http://www.cocoachina.com/ios/20150525/11919.html)

&emsp;&emsp;MVVM的出现主要是为了解决在开发过程中Controller越来越庞大的问题，变得难以维护，所以MVVM把数据加工的任务从Controller中解放了出来，使得Controller只需要专注于数据调配的工作，ViewModel则去负责数据加工并通过通知机制让View响应ViewModel的改变。

&emsp;&emsp;MVVM是基于胖Model的架构思路建立的，然后在胖Model中拆出两部分：Model和ViewModel。ViewModel本质上算是Model层（因为是胖Model里面分出来的一部分），所以View并不适合直接持有ViewModel，因为ViewModel有可能并不是只服务于特定的一个View，使用更加松散的绑定关系能够降低ViewModel和View之间的耦合度。

&emsp;&emsp;还有一个让人很容易忽略的问题，大部分国内外资料阐述MVVM的时候都是这样排布的：
```
View<->ViewModel <->Model
```
造成了MVVM不需要Controller的错觉，现在似乎发展成业界开始出现MVVM是不需要Controller的声音了。其实MVVM是一定需要Controller的参与的，虽然MVVM在一定程度上弱化了Controller的存在感，并且给Controller做了减负瘦身（这也是MVVM的主要目的）。但是，这并不代表MVVM中不需要Controller，MMVC和MVVM他们之间的关系应该是这样：
```
View <-> C <-> ViewModel <->Model
```
所以使用MVVM之后，就不需要Controller的说法是不正确的。严格来说MVVM其实是MVCVM。从中可以得知，Controller夹在View和ViewModel之间做的其中一个主要事情就是将View和ViewModel进行绑定。在逻辑上，Controller知道应当展示哪个View，Controller也知道应当使用哪个ViewModel，然而View和ViewModel它们之间是互相不知道的，所以Controller就负责控制他们的绑定关系，所以叫Controller/控制器就是这个原因。

&emsp;&emsp;前面扯了那么多，其实归根结底就是一句话：在MVC的基础上，把C拆出一个ViewModel专门负责数据处理的事情，就是MVVM。然后，为了让View和ViewModel之间能够有比较松散的绑定关系，于是我们使用ReactiveCocoa，KVO，Notification，block，delegate和target-action都可以用来做数据通信，从而来实现绑定，但都不如ReactiveCocoa提供的RACSignal来的优雅，如果不用ReactiveCocoa，绑定关系可能就做不到那么松散那么好，但并不影响它还是MVVM。

##MVVM(View-ViewManger-C-ViewModel-Model)
![image](https://github.com/lovemo/MVVMFramework/raw/master/MVVMFramework/screenshots/MVVMFrameWork-Thinking.png)
- [View - 用来呈现用户界面](#1)
- [ViewManger - 用来处理View的常规事件，负责管理View](#2)
- [Controller - 负责ViewManger和ViewModel之间的绑定，负责控制器本身的生命周期。](#3)
- [ViewModel - 存放各种业务逻辑和网络请求](#4)
- [Model - 用来呈现数据](#5)
![image](https://github.com/lovemo/MVVMFramework/raw/master/tree.jpeg)

====

&emsp;&emsp;这种设计的目的是保持View和Model的高度纯洁，提高可扩展性和复用度。在日常开发中，ViewModel是为了拆分Controller业务逻辑而存在的，所以ViewModel需要提供公共的服务接口，以便为Controller提供数据。而ViewManger的作用相当于一个小管家，帮助Controller来分别管理每个subView，ViewManger负责接管来自View的事件，也负责接收来自Controller的模型数据，进行自己所负责的视图数据绑定工作。Controller则是最后的大家长，负责将ViewModel和ViewManger进行绑定，进行数据转发工作。把合适的数据模型分发给合适的视图管理者。

&emsp;&emsp;日常开发中，往往一个视图页面交由一个控制器进行管理，而一个页面上又有N个小的子页面，这就要求我们来对这些视图进行合适的分层处理，拆分视图，将这些视图进行封装，将复杂View抽象成独立的类，不必暴露出具体的实现细节。这样做的好处是，简化应用层的层级复杂度，同时也方便进行管理，视图结构就会变得很清晰。子视图具体的内部事件，可通过代理模式或者Block交由ViewManger处理，因为视图是可以复用的，而其中的事件响应代码往往是根据不同的业务是有差异的。所以可能会有下面两种情况出现：
- [View很纯洁，需要复用View，若业务逻辑变化则切换ViewManger。](#6)
- [ViewManger也比较纯洁，若业务逻辑不变，而View需要大变，则切换View即可，保证View中的protocol或者block一致即可<最好是通过协议提前规范好>。](#7)

&emsp;&emsp;这样就实现了互相的封装，两者之间只通过protocol或者block进行交流通信，降低了代码的耦合度。尽量使用protocol和category来制定对象之间的通信规范，来降低代码的侵入性。

&emsp;&emsp;这样的架构设计，就像一条生产线，ViewModel进行数据的采集和加工，Controller则进行数据的装配和转发工作，ViewManger进行接收转发分配来的数据，从而进行负责View的展示工作和管理View的事件。这样，不管哪个环节，都是可以更换的，同时也提高了复用性。

&emsp;&emsp;至于是否采用更轻量级的ViewController做法，即 `通过将各个 protocol 的实现挪到 ViewController 之外，来为 ViewController 瘦身` ,众口不一。以UITableView为例，我的做法是：
- 如果只是在页面上进行简单的展示，并不设计负责的业务逻辑时，会将UITableViewDelegate与UITableViewDataSource单独放到一个Handler钟进行处理，抽象出tableHander，由MVVMTableDataDelegate进行负责管理；
- 当然，事实上，实际开发中，每个tableView页面都很复杂，有很多逻辑要处理，这时候只能考虑将protocol重新请回Controller中了，因为View层与ViewController层本身是持有与被持有的依赖关系，所以任何类作为ViewController的类内实例来实现协议回调，实际上都是在跨层调用，所以，随着时间和业务逻辑的愈来愈复杂，就注定要以额外的接口为代价，换言之，ViewController 的内聚性变差了。
总之，具体情况具体分析，采用最合适的方式来处理应对不同的问题。兵来将挡，水来土掩。

&emsp;&emsp;本文的相关Demo见github，实现的功能并不复杂，仅供参考，欢迎补充。

####如果想学习更多关于MVVM的文章，请参考本项目demo中下方的推荐文章。

###未完待续。。。
