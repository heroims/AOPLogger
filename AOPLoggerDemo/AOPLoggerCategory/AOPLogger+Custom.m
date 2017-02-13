//
//  AOPLogger+Custom.m
//  AOPLoggerDemo
//
//  Created by admin on 2017/2/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AOPLogger+Custom.h"
#import "Aspects.h"
#import <objc/runtime.h>

@implementation AOPLogger (Custom)

-(void)al_logger:(id)log originAOP:(id)originAOP{
    if ([log isKindOfClass:[NSString class]]) {
        NSLog(@"event:%@",log);
    }
    if ([log isKindOfClass:[NSDictionary class]]) {
        NSLog(@"eventName:%@\neventLabel:%@\neventTime:%@",log[@"EventName"],log[@"EventLabel"],[log[@"EventTime"] boolValue]?[NSDate date]:@"不用获取");
    }
    if (originAOP&&[originAOP conformsToProtocol:objc_getProtocol("AspectInfo")]) {
        id<AspectInfo> aspectInfo=originAOP;
        NSLog(@"originClass:%@\noriginSel:%@",NSStringFromClass([aspectInfo.originalInvocation.target class]),NSStringFromSelector(aspectInfo.originalInvocation.selector));

        for (NSInteger i=0; i<aspectInfo.arguments.count; i++) {
            NSLog(@"argument:%@",aspectInfo.arguments[i]);
        }
    }
}

@end
