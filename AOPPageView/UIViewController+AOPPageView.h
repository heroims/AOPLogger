//
//  UIViewController+AOPPageView.h
//  xgoods
//
//  Created by admin on 2017/7/31.
//  Copyright © 2017年 Look. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AOPLoggerPageViewProtocol <NSObject>

@optional
-(BOOL)alpvp_viewIgnore:(id)sender;
-(void)alpvp_viewDidAppear:(BOOL)animated sender:(id)sender;
-(void)alpvp_viewDidDisappear:(BOOL)animated sender:(id)sender;

@end

@interface UIViewController (AOPPageView)

@end
