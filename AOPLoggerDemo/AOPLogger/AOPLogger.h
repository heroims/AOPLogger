//
//  AOPLogger.h
//  AOPLoggerDemo
//
//  Created by admin on 2017/2/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const AOPLoggerMethod;
extern NSString * const AOPLoggerLogInfo;
extern NSString * const AOPLoggerPositionAfter;
extern NSString * const AOPLoggerPositionBefore;
extern NSString * const AOPLoggerPositionType;

@protocol AOPLoggerGetConfigInfoProtocol <NSObject>

@required
-(NSDictionary*)al_getConfigInfo;

@end
@protocol AOPLoggerBLLProtocol <NSObject>

@required
-(void)al_logger:(id)log originAOP:(id)originAOP;

@end

@interface AOPLogger : NSObject

+(void)startAOPLoggerWithPlist;

+(void)AOPLoggerWithClassString:(NSString*)classString methodString:(NSString*)methodString log:(id)log;

+(void)AOPLoggerWithClassString:(NSString *)classString methodString:(NSString *)methodString log:(id)log logPosition:(NSString*)logPosition;

@end
