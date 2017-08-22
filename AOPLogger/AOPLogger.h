//
//  AOPLogger.h
//  AOPLoggerDemo
//
//  Created by admin on 2017/2/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

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

+ (AOPLogger *)sharedAOPLogger;

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

@interface NSObject (AOPLogger)

/**
 替换或添加类方法，即使替换过也会替换，注意想单次替换使用dispatch_once保证，如果方法从未声明过则会添加失败
 
 @param originalSelector 原方法
 @param swizzledSelector 替换方法
 @param error 错误信息
 */
+(void)al_hookOrAddWithOriginClassSeletor:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector error:(NSError**)error;


/**
 替换或添加实例方法，即使替换过也会替换，注意想单次替换使用dispatch_once保证，如果方法从未声明过则会添加失败

 @param originalSelector 原方法
 @param swizzledSelector 替换方法
 @param error 错误信息
 */
+(void)al_hookOrAddWithOriginSeletor:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector error:(NSError**)error;

@end

