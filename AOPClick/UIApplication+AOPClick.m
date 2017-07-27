//
//  UIApplication+AnalyzerClick.m
//  xgoods
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 Look. All rights reserved.
//

#import "UIApplication+AOPClick.h"

#import <Aspects/Aspects.h>
#import <objc/runtime.h>
#import "AOPLogger.h"

@implementation UIApplication (AOPClick)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self al_hookOrAddWithOriginSeletor:@selector(sendAction:to:from:forEvent:) swizzledSelector:@selector(ac_sendAction:to:from:forEvent:) error:nil];
    });
}

-(BOOL)ac_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event{
    AOPLogger<AOPLoggerClickProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerClickProtocol>*)[AOPLogger sharedAOPLogger];
    if ([aopLoggerEngine respondsToSelector:@selector(alcp_customIgnore_sendAction:to:from:forEvent:)]) {
        [aopLoggerEngine alcp_customIgnore_sendAction:action to:target from:sender forEvent:event];
    }
    else{
        if ([sender isKindOfClass:[UIView class]]) {
            if ([sender isKindOfClass:[UIBarButtonItem class]] ||
                [sender isKindOfClass:[NSClassFromString(@"UITabBarButton") class]]||[sender isKindOfClass:[UITextField class]] ||
                [sender isKindOfClass:[NSClassFromString(@"UITextField") class]]||[sender isKindOfClass:[UITextView class]] ||
                [sender isKindOfClass:[NSClassFromString(@"UITextView") class]]) {
                
            }
            else{
                if ([aopLoggerEngine respondsToSelector:@selector(alcp_sendAction:to:from:forEvent:)]) {
                    [aopLoggerEngine alcp_sendAction:action to:target from:sender forEvent:event];
                }
            }
        }
    }

    return [self ac_sendAction:action to:target from:sender forEvent:event];
}

@end

static const void *delegateCollectionViewIsHook = &delegateCollectionViewIsHook;

@interface UICollectionView (AOPClick)

@end
@implementation UICollectionView(AOPClick)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            [[self class] al_hookOrAddWithOriginSeletor:@selector(setDelegate:) swizzledSelector:@selector(am_setDelegate:) error:nil];
        }
        @catch (NSException *exception) {
        }
    });
    
}

-(void)am_setDelegate:(id<UICollectionViewDelegate>)delegate{
    [self am_setDelegate:delegate];
    if (delegate&&[delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        NSNumber *isHook=objc_getAssociatedObject(delegate, delegateCollectionViewIsHook);
        if (isHook==nil||![isHook boolValue]) {
            @try {
                NSError *error=nil;
                [(NSObject*)delegate aspect_hookSelector:@selector(collectionView:didSelectItemAtIndexPath:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                    AOPLogger<AOPLoggerClickProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerClickProtocol>*)[AOPLogger sharedAOPLogger];
                    if ([aopLoggerEngine respondsToSelector:@selector(alcp_collectionView:didSelectItemAtIndexPath:from:)]) {
                        [aopLoggerEngine alcp_collectionView:aspectInfo.arguments[0] didSelectItemAtIndexPath:aspectInfo.arguments[1] from:aspectInfo.instance];
                    }
                    
                    
                } error:&error];
                objc_setAssociatedObject(delegate, delegateCollectionViewIsHook, @(YES), OBJC_ASSOCIATION_RETAIN);
            }
            @catch (NSException *exception) {
            }
            
        }
    }
}


@end

static const void *delegateTableViewIsHook = &delegateTableViewIsHook;

@interface UITableView (AOPClick)

@end
@implementation UITableView(AOPClick)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            [[self class] al_hookOrAddWithOriginSeletor:@selector(setDelegate:) swizzledSelector:@selector(am_setDelegate:) error:nil];
        }
        @catch (NSException *exception) {
        }
    });
    
}

-(void)am_setDelegate:(id<UITableViewDelegate>)delegate{
    [self am_setDelegate:delegate];
    if (delegate&&[delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        NSNumber *isHook=objc_getAssociatedObject(delegate, delegateTableViewIsHook);
        if (isHook==nil||![isHook boolValue]) {
            @try {
                NSError *error=nil;
                [(NSObject*)delegate aspect_hookSelector:@selector(tableView:didSelectRowAtIndexPath:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                    AOPLogger<AOPLoggerClickProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerClickProtocol>*)[AOPLogger sharedAOPLogger];
                    if ([aopLoggerEngine respondsToSelector:@selector(alcp_tableView:didSelectRowAtIndexPath:from:)]) {
                        [aopLoggerEngine alcp_tableView:aspectInfo.arguments[0] didSelectRowAtIndexPath:aspectInfo.arguments[1] from:aspectInfo.instance];
                    }

                } error:&error];
                objc_setAssociatedObject(delegate, delegateTableViewIsHook, @(YES), OBJC_ASSOCIATION_RETAIN);
            }
            @catch (NSException *exception) {
            }
            
        }
    }
}


@end

static const void *delegateTabBarControllerIsHook = &delegateTabBarControllerIsHook;

@interface UITabBarController (AOPClick)

@end
@implementation UITabBarController(AOPClick)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            [[self class] al_hookOrAddWithOriginSeletor:@selector(setDelegate:) swizzledSelector:@selector(am_setDelegate:)error:nil];
        }
        @catch (NSException *exception) {
        }
    });
    
}

-(void)am_setDelegate:(id<UITabBarControllerDelegate>)delegate{
    [self am_setDelegate:delegate];
    if (delegate&&[delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        NSNumber *isHook=objc_getAssociatedObject(delegate, delegateTabBarControllerIsHook);
        if (isHook==nil||![isHook boolValue]) {
            @try {
                NSError *error=nil;
                [(NSObject*)delegate aspect_hookSelector:@selector(tabBarController:didSelectViewController:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                    AOPLogger<AOPLoggerClickProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerClickProtocol>*)[AOPLogger sharedAOPLogger];
                    if ([aopLoggerEngine respondsToSelector:@selector(alcp_tabBarController:didSelectViewController:from:)]) {
                        [aopLoggerEngine alcp_tabBarController:aspectInfo.arguments[0] didSelectViewController:aspectInfo.arguments[1] from:aspectInfo.instance];
                    }
                } error:&error];
                objc_setAssociatedObject(delegate, delegateTabBarControllerIsHook, @(YES), OBJC_ASSOCIATION_RETAIN);
            }
            @catch (NSException *exception) {
            }
            
        }
    }
}


@end

static const void *delegateTabBarIsHook = &delegateTabBarIsHook;

@interface UITabBar (AOPClick)

@end
@implementation UITabBar(AOPClick)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            [[self class] al_hookOrAddWithOriginSeletor:@selector(setDelegate:) swizzledSelector:@selector(am_setDelegate:) error:nil];
        }
        @catch (NSException *exception) {
        }
    });
    
}

-(void)am_setDelegate:(id<UITabBarDelegate>)delegate{
    [self am_setDelegate:delegate];
    if (delegate&&[delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        NSNumber *isHook=objc_getAssociatedObject(delegate, delegateTabBarIsHook);
        if (isHook==nil||![isHook boolValue]) {
            @try {
                NSError *error=nil;
                [(NSObject*)delegate aspect_hookSelector:@selector(tabBar:didSelectItem:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                    AOPLogger<AOPLoggerClickProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerClickProtocol>*)[AOPLogger sharedAOPLogger];
                    if ([aopLoggerEngine respondsToSelector:@selector(alcp_tabBar:didSelectItem:from:)]) {
                        [aopLoggerEngine alcp_tabBar:aspectInfo.arguments[0] didSelectItem:aspectInfo.arguments[1] from:aspectInfo.instance];
                    }
                    
                } error:&error];
                objc_setAssociatedObject(delegate, delegateTabBarIsHook, @(YES), OBJC_ASSOCIATION_RETAIN);
            }
            @catch (NSException *exception) {
            }
            
        }
    }
}


@end

static const void *delegateAlertViewIsHook = &delegateAlertViewIsHook;

@interface UIAlertView (AOPClick)

@end
@implementation UIAlertView(AOPClick) 

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            [[self class] al_hookOrAddWithOriginSeletor:@selector(setDelegate:) swizzledSelector:@selector(am_setDelegate:) error:nil];
        }
        @catch (NSException *exception) {
        }
    });
    
}

-(void)am_setDelegate:(id<UIAlertViewDelegate>)delegate{
    [self am_setDelegate:delegate];
    if (delegate&&[delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        NSNumber *isHook=objc_getAssociatedObject(delegate, delegateAlertViewIsHook);
        if (isHook==nil||![isHook boolValue]) {
            @try {
                NSError *error=nil;
                [(NSObject*)delegate aspect_hookSelector:@selector(alertView:clickedButtonAtIndex:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                    AOPLogger<AOPLoggerClickProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerClickProtocol>*)[AOPLogger sharedAOPLogger];
                    if ([aopLoggerEngine respondsToSelector:@selector(alcp_alertView:clickedButtonAtIndex:from:)]) {
                        [aopLoggerEngine alcp_alertView:aspectInfo.arguments[0] clickedButtonAtIndex:[aspectInfo.arguments[1] integerValue] from:aspectInfo.instance];
                    }
                } error:&error];
                objc_setAssociatedObject(delegate, delegateAlertViewIsHook, @(YES), OBJC_ASSOCIATION_RETAIN);
            }
            @catch (NSException *exception) {
            }
            
        }
    }
}


@end

static const void *delegateActionSheetIsHook = &delegateActionSheetIsHook;

@interface UIActionSheet (AnalyzerClick)

@end
@implementation UIActionSheet(AnalyzerClick)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            [[self class] al_hookOrAddWithOriginSeletor:@selector(setDelegate:) swizzledSelector:@selector(am_setDelegate:) error:nil];
        }
        @catch (NSException *exception) {
        }
    });
    
}

-(void)am_setDelegate:(id<UIActionSheetDelegate>)delegate{
    [self am_setDelegate:delegate];
    if (delegate&&[delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        NSNumber *isHook=objc_getAssociatedObject(delegate, delegateActionSheetIsHook);
        if (isHook==nil||![isHook boolValue]) {
            @try {
                NSError *error=nil;
                [(NSObject*)delegate aspect_hookSelector:@selector(actionSheet:clickedButtonAtIndex:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                    AOPLogger<AOPLoggerClickProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerClickProtocol>*)[AOPLogger sharedAOPLogger];
                    if ([aopLoggerEngine respondsToSelector:@selector(alcp_actionSheet:clickedButtonAtIndex:from:)]) {
                        [aopLoggerEngine alcp_actionSheet:aspectInfo.arguments[0] clickedButtonAtIndex:[aspectInfo.arguments[1] integerValue] from:aspectInfo.instance];
                    }
                    
                } error:&error];
                objc_setAssociatedObject(delegate, delegateActionSheetIsHook, @(YES), OBJC_ASSOCIATION_RETAIN);
            }
            @catch (NSException *exception) {
            }
            
        }
    }
}


@end


@interface UIAlertAction (AnalyzerClick)

@end
@implementation UIAlertAction (AnalyzerClick)

+(void)load{    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            [[self class] al_hookOrAddWithOriginSeletor:NSSelectorFromString(@"setHandler:") swizzledSelector:@selector(lkam_setHandler:) error:nil];
        }
        @catch (NSException *exception) {
        }
    });

}

-(void)lkam_setHandler:(void (^)(UIAlertAction * _Nonnull))handler{
    void (^customHandler)(UIAlertAction * action) = ^(UIAlertAction *action){
        AOPLogger<AOPLoggerClickProtocol> *aopLoggerEngine=(AOPLogger<AOPLoggerClickProtocol>*)[AOPLogger sharedAOPLogger];
        if ([aopLoggerEngine respondsToSelector:@selector(alcp_alertControllerAction:from:)]) {
            [aopLoggerEngine alcp_alertControllerAction:action from:self];
        }

        if (handler) {
            handler(action);
        }
    };
    [self lkam_setHandler:customHandler];
}
@end
