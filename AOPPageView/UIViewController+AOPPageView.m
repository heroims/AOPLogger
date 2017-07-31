//
//  UIViewController+AOPPageView.m
//  xgoods
//
//  Created by admin on 2017/7/31.
//  Copyright © 2017年 Look. All rights reserved.
//

#import "UIViewController+AOPPageView.h"

#import <Aspects/Aspects.h>
#import <objc/runtime.h>
#import "AOPLogger.h"

@implementation UIViewController (AOPPageView)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self al_hookOrAddWithOriginSeletor:@selector(viewDidAppear:) swizzledSelector:@selector(apv_viewDidAppear:) error:nil];
        [self al_hookOrAddWithOriginSeletor:@selector(viewDidDisappear:) swizzledSelector:@selector(apv_viewDidDisappear:) error:nil];
    });

}

-(BOOL)apv_viewIgnore{
    AOPLogger<AOPLoggerPageViewProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerPageViewProtocol>*)[AOPLogger sharedAOPLogger];
    if ([aopLoggerEngine respondsToSelector:@selector(alpvp_viewIgnore:)]) {
        return [aopLoggerEngine alpvp_viewIgnore:self];
    }
    else{
        NSString *screenName=NSStringFromClass([self class]);
        
        if ([screenName isEqualToString:@"SFBrowserRemoteViewController"] ||
            [screenName isEqualToString:@"SFSafariViewController"] ||
            [screenName isEqualToString:@"UIAlertController"] ||
            [screenName isEqualToString:@"UIInputWindowController"] ||
            [screenName isEqualToString:@"UINavigationController"] ||
            [screenName isEqualToString:@"UIKeyboardCandidateGridCollectionViewController"] ||
            [screenName isEqualToString:@"UICompatibilityInputViewController"] ||
            [screenName isEqualToString:@"UIApplicationRotationFollowingController"] ||
            [screenName isEqualToString:@"UIApplicationRotationFollowingControllerNoTouches"] ||
            [screenName isEqualToString:@"UIViewController"]
            ) {
            return YES;
        }
        
        if ([self isKindOfClass:NSClassFromString(@"UINavigationController")] ||
            [self isKindOfClass:NSClassFromString(@"UITabBarController")]) {
            return YES;
        }
        return NO;

    }
}

-(void)apv_viewDidAppear:(BOOL)animated{
    [self apv_viewDidAppear:animated];
    if ([self apv_viewIgnore]) {
        return;
    }
    AOPLogger<AOPLoggerPageViewProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerPageViewProtocol>*)[AOPLogger sharedAOPLogger];
    if ([aopLoggerEngine respondsToSelector:@selector(alpvp_viewDidAppear:sender:)]) {
        [aopLoggerEngine alpvp_viewDidAppear:animated sender:self];
    }

}

-(void)apv_viewDidDisappear:(BOOL)animated{
    [self apv_viewDidDisappear:animated];
    
    if ([self apv_viewIgnore]) {
        return;
    }

    AOPLogger<AOPLoggerPageViewProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerPageViewProtocol>*)[AOPLogger sharedAOPLogger];
    if ([aopLoggerEngine respondsToSelector:@selector(alpvp_viewDidDisappear:sender:)]) {
        [aopLoggerEngine alpvp_viewDidDisappear:animated sender:self];
    }

}

@end
