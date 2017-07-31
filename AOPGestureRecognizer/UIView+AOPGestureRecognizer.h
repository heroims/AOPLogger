//
//  UIView+AOPGestureRecognizer.h
//  xgoods
//
//  Created by admin on 2017/7/31.
//  Copyright © 2017年 Look. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AOPLoggerGestureRecognizerProtocol <NSObject>

@optional
-(void)algrp_handleGesture:(UIGestureRecognizer*)gestureRecognizer;

@end

@interface UIView (AOPGestureRecognizer)

@end
