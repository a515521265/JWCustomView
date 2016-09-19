//
//  UITabBar+Badge.h
//  songShuFinance
//
//  Created by 梁家文 on 16/1/7.
//  Copyright © 2016年 李贵文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点


/**
 *  用法事例
 [self.tabBarController.tabBar showBadgeOnItemIndex:2];
 [self.tabBarController.tabBar showBadgeOnItemIndex:3];
 [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"new"]];
 */


@end
