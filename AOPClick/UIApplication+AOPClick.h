//
//  UIApplication+AnalyzerClick.h
//  xgoods
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 Look. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AOPLoggerClickProtocol <NSObject>

@optional
- (void)alcp_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event;
- (void)alcp_customIgnore_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event;
- (void)alcp_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath from:(id)sender;
- (void)alcp_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath from:(id)sender;
- (void)alcp_tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController from:(id)sender;
- (void)alcp_tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item from:(id)sender;
- (void)alcp_alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex from:(id)sender;
- (void)alcp_actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex from:(id)sender;
- (void)alcp_alertControllerAction:(UIAlertAction *)action from:(id)sender;

@end

@interface UIApplication (AOPClick)

@end
