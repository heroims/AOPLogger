//
//  UIView+AOPGestureRecognizer.m
//  xgoods
//
//  Created by admin on 2017/7/31.
//  Copyright © 2017年 Look. All rights reserved.
//

#import "UIView+AOPGestureRecognizer.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>
#import "AOPLogger.h"

@implementation UIView (AOPGestureRecognizer)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self al_hookOrAddWithOriginSeletor:@selector(addGestureRecognizer:) swizzledSelector:@selector(agr_addGestureRecognizer:) error:nil];
    });

}

-(void)agr_addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    [gestureRecognizer addTarget:self action:@selector(agr_handleGesture:)];

    [self agr_addGestureRecognizer:gestureRecognizer];
}

-(void)agr_handleGesture:(UIGestureRecognizer*)gestureRecognizer{
    AOPLogger<AOPLoggerGestureRecognizerProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerGestureRecognizerProtocol>*)[AOPLogger sharedAOPLogger];
    if ([aopLoggerEngine respondsToSelector:@selector(algrp_handleGesture:)]) {
        [aopLoggerEngine algrp_handleGesture:gestureRecognizer];
    }
}

@end
