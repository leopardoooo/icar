//
//  AppDelegate.m
//  icar
//
//  Created by Killer on 15/11/3.
//  Copyright (c) 2015年 杭州聚轮网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "MacroDefine.h"
#import "WelcomeViewController.h"
#import "Settings.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 隐藏返回图标的文字
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1300, 0) forBarMetrics:UIBarMetricsDefault];
    
    // 设置返回图标
//    [UINavigationBar appearance].backIndicatorImage = [[UIImage imageNamed:@"btn_backItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"btn_backItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
    [UINavigationBar appearance].tintColor = [UIColor colorWithWhite:0.351 alpha:1.000];
//    UIFont *font = [UIFont systemFontOfSize:13];
//    [UIButton appearance].titleLabel.font = font;
//    [UILabel appearance].font = font;
//    [UITextView appearance].font = font;
//    [UITextField appearance].font = font;
    
    //FIXME: 启动正在开发的页面，后期请删除该段代码
//    UITabBarController *tabs = (UITabBarController *) _window.rootViewController;
//    tabs.selectedIndex = 2;
    
    // 检查是否第一次启动
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:sysDefaultFirstLaunchKey]){
        [defaults setBool:YES forKey:sysDefaultFirstLaunchKey];
        
        // 启动欢迎页
        WelcomeViewController *tmpVc = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:[NSBundle mainBundle]];
        tmpVc.rootViewController = _window.rootViewController;
        tmpVc.window = _window;
        _window.rootViewController = tmpVc;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
