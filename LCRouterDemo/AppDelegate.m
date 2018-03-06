//
//  AppDelegate.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/2.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LCRouter.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor orangeColor];
    [self.window makeKeyAndVisible];  // 设为keyWindow 并显示出来
    
    UITabBarController *tabBarVC = [UITabBarController new];
    for (NSInteger i = 0; i < 2; i++) {
        [tabBarVC addChildViewController:({
            ViewController *vc = [ViewController new];
            vc.title = [NSString stringWithFormat:@"ViewController%ld",i + 1];
            BaseNavigationController *navVC = [[BaseNavigationController alloc] initWithRootViewController:vc];
            navVC;
        })];
    }
    self.window.rootViewController = tabBarVC;
    
    
    // plist 文件不一定要加,若不加,则直接将字符串转为Class
    [LCRouter loadConfigDictFromPlist:@"LCURLRouter.plist"];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
