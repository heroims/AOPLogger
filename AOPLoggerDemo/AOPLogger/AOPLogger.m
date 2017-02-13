//
//  AOPLogger.m
//  AOPLoggerDemo
//
//  Created by admin on 2017/2/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AOPLogger.h"
#import "Aspects.h"
#import <objc/runtime.h>

NSString * const AOPLoggerMethod=@"AOPLoggerMethod";
NSString * const AOPLoggerLogInfo=@"AOPLoggerLogInfo";

@implementation AOPLogger

+ (AOPLogger *)sharedAOPLogger {
    static AOPLogger *sharedAOPLogger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAOPLogger = [[self alloc] init];
    });
    return sharedAOPLogger;
}

+(void)startAOPLoggerWithPlist{
    NSDictionary *loggerConfigInfo=nil;
    if ([[AOPLogger sharedAOPLogger] conformsToProtocol:objc_getProtocol("AOPLoggerGetConfigInfoProtocol")]) {
        loggerConfigInfo=[(AOPLogger<AOPLoggerGetConfigInfoProtocol>*)[AOPLogger sharedAOPLogger] al_getConfigInfo];
    }
    else{
        loggerConfigInfo=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AOPLoggerConfig" ofType:@"plist"]];
    }
    
    for (NSString *className in loggerConfigInfo) {
        for (NSDictionary *eventInfo in loggerConfigInfo[className]) {
            Class clazz = NSClassFromString(className);
            SEL selector = NSSelectorFromString(eventInfo[AOPLoggerMethod]);
            
            [clazz aspect_hookSelector:selector
                           withOptions:AspectPositionAfter
                            usingBlock:^(id<AspectInfo> aspectInfo) {
                                id log=eventInfo[AOPLoggerLogInfo];
                                
                                if ([[AOPLogger sharedAOPLogger] conformsToProtocol:objc_getProtocol("AOPLoggerBLLProtocol")]) {
                                    [(AOPLogger<AOPLoggerBLLProtocol>*)[AOPLogger sharedAOPLogger] al_logger:log originAOP:aspectInfo];
                                }
                                else{
                                    if ([log isKindOfClass:[NSString class]]) {
                                        NSLog(@"AOPLogger:%@",log);
                                    }
                                }
                            } error:NULL];
            
        }
    }

}

+(void)AOPLoggerWithClassString:(NSString *)classString methodString:(NSString *)methodString log:(id)log{
    Class clazz = NSClassFromString(classString);
    SEL selector = NSSelectorFromString(methodString);

    [clazz aspect_hookSelector:selector
                   withOptions:AspectPositionAfter
                    usingBlock:^(id<AspectInfo> aspectInfo) {
                        if ([[AOPLogger sharedAOPLogger] conformsToProtocol:objc_getProtocol("AOPLoggerBLLProtocol")]) {
                            [(AOPLogger<AOPLoggerBLLProtocol>*)[AOPLogger sharedAOPLogger] al_logger:log originAOP:aspectInfo];
                        }
                        else{
                            if ([log isKindOfClass:[NSString class]]) {
                                NSLog(@"AOPLogger:%@",log);
                            }
                        }
                    } error:NULL];

}

@end
