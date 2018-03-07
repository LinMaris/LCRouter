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
#import "LCNavigation.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

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
    
    
    // plist文件的优点是 避免url在项目中散落,不好管理,但我感觉用处并不大
    // 若不加, 对于LCNavigation ,则直接将传入的字符串转为Class
    // 对于 LCNotification, 无影响, 因为他没用到这个plist文件
    [LCRouter loadConfigDictFromPlist:@"LCURLRouter.plist"];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSLog(@"LCRouter==>url:%@",url);
    
//    UIViewController *currentVC = [LCRouter sharedLCRouter].currentViewController;

    NSDictionary *urlDic = [[LCNavigation sharedLCNavigation] paramsURL:url];
    NSLog(@"urlDic:==>%@==>%@==>%@",url.scheme,url.host,url.path);
    
    [LCRouter pushURLString:urlDic[@"targetVC"] params:urlDic animated:true];
    
    return true;
}

@end
