# AOPLogger 切面日志 ![](http://cocoapod-badges.herokuapp.com/v/AOPLogger/badge.png) ![](http://cocoapod-badges.herokuapp.com/p/AOPLogger/badge.png)
## 目的
主要是为了从主工程内分离，可以单独的写日志系统，通过类扩展定制不同的统计方式
## 调用
程序内调用这里就不多说了，看注释就都懂了
这里详细说说用Plist的形式或者其他形式，内部真实的字典结构可以看下面Plist的图了解

![Screenshot1](http://heroims.github.io/AOPLogger/QQ20170306-012628.png "Screenshot1") 

最外层的Key就是对应的类名内部对应一个字典，基础Key就是提供的几个常量，要统计的方法名，要统计的方法执行类型，最后是要统计的日志信息，这里再细说一下要统计的日志信息，其实可以在类扩展里加入定制，这样甚至可以根据要统计的日志信息，根据信息内容处理要执行的方法怎么处理怎么记录
###
```Objective-C
extern NSString * const AOPLoggerMethod;//要统计的日志方法Key
extern NSString * const AOPLoggerLogInfo;//要统计的日志信息Key
extern NSString * const AOPLoggerPositionAfter;//方法执行后统计日志
extern NSString * const AOPLoggerPositionBefore;//方法执行前统计日志
extern NSString * const AOPLoggerPositionType;//执行日志统计的类型Key

@protocol AOPLoggerGetConfigInfoProtocol <NSObject>

@required

/**
 创建类扩展如果使用此协议必须实现此方法
 此方法返回统计的配置信息，可以从网络取也可以从本地取

 @return 统计配置字典
 */
-(NSDictionary*)al_getConfigInfo;

@end
@protocol AOPLoggerBLLProtocol <NSObject>

@required

/**
 创建类扩展如果使用此协议必须实现此方法
 此方法主要来处理切面方法后的log信息处理可以存本地也可以使用其他任意第三方输出

 @param log 配置文件里定义的AOPLoggerLogInfo信息
 @param originAOP AspectInfo的方法信息，第三方库Aspect返回的切面方法的所有信息
 */
-(void)al_logger:(id)log originAOP:(id)originAOP;

@end

@interface AOPLogger : NSObject


/**
 开始读取日志Plist配置文件
 */
+(void)startAOPLoggerWithPlist;

/**
 统计日志的调用方法
 （如果不想增加开机时间可以采取每个模块创建一个日志统计类适时调用，在该类里提供一个初始化方法，内部调用此即可）

 @param classString 类名
 @param methodString 方法名
 @param log 相当于AOPLoggerLogInfo信息
 */
+(void)AOPLoggerWithClassString:(NSString*)classString methodString:(NSString*)methodString log:(id)log;

/**
 统计日志的调用方法
 （如果不想增加开机时间可以采取每个模块创建一个日志统计类适时调用，在该类里提供一个初始化方法，内部调用此即可）

 @param classString 类名
 @param methodString 方法名
 @param log 相当于AOPLoggerLogInfo信息
 @param logPosition 日志统计时位置，可放在方法运行前或运行后（默认运行后执行日志统计）
 */
+(void)AOPLoggerWithClassString:(NSString *)classString methodString:(NSString *)methodString log:(id)log logPosition:(NSString*)logPosition;

@end

```
## Installation

### via CocoaPods
Install CocoaPods if you do not have it:-
````
$ [sudo] gem install cocoapods
$ pod setup
````
Create Podfile:-
````
$ edit Podfile
platform :ios, '5.0'

pod 'AOPLogger'

#切面所有点击事件
pod 'AOPLogger/AOPClick'

#切面所有手势事件
pod 'AOPLogger/AOPGestureRecognizer'

#切面所有页面进入离开
pod 'AOPLogger/AOPPageView'

$ pod install
````
Use the Xcode workspace instead of the project from now on.

### App的生命周期处理
随便建个类监听下面通知即可

UIApplicationDidFinishLaunchingNotification （通知名称）  --->   application:didFinishLaunchingWithOptions:(委托方法）：在应用程序启动后直接进行应用程序级编码的主要方式。

UIApplicationWillResignActiveNotification(通知名称）--->applicationWillResignActive:（委托方法）：用户按下主屏幕按钮调用 ，不要在此方法中假设将进入后台状态，只是一种临时变化，最终将恢复到活动状态

UIApplicationDidBecomActiveNotification（通知名称） ---->applicationDidBecomeActive:(委托方法）：应用程序按下主屏幕按钮后想要将应用程序切换到前台时调用，应用程序启动时也会调用，可以在其中添加一些应用程序初始化代码

UIApplicationDidEnterBackgroundNotification(通知名称）----->applicationDidEnterBackground:（委托方法）：应用程序在此方法中释放所有可在以后重新创建的资源，保存所有用户数据，关闭网络连接等。如果需要，也可以在这里请求在后台运行更长时间。如果在这里花费了太长时间（超过5秒），系统将断定应用程序的行为异常并终止他。

UIApplicationWillEnterForegroundNotification(通知名称） ---->applicationWillEnterForeground:(委托方法):当应用程序在applicationDidEnterBackground:花费了太长时间，终止后，应该实现此方法来重新创建在applicationDidEnterBackground中销毁的内容，比如重新加载用户数据、重新建立网络连接等。

UIApplicationWllTerminateNotification（通知名称） ----> applicationWillTerminate:(委托方法):现在很少使用，只有在应用程序已进入后台，并且系统出于某种原因决定跳过暂停状态并终止应用程序时，才会真正调用它。

