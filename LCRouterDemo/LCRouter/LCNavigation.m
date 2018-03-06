//
//  LCNavigation.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/3.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "LCNavigation.h"

@implementation LCNavigation

LCSingletonM(LCNavigation)

-(UIViewController *)currentViewController
{
    return [[LCNavigation sharedLCNavigation] currentViewControllerFrom:[self rootViewController]];
}

-(UINavigationController *)currentNavigationViewController
{
    return [self currentViewController].navigationController;
}

-(UIViewController*)rootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [LCNavigation setRootViewController:viewController];
    }  // 如果是导航控制器直接设置为根控制器
    else {
        UINavigationController *navigationController = [LCNavigation sharedLCNavigation].currentNavigationViewController;
        
        if (navigationController) { // 导航控制器存在
            [navigationController pushViewController:viewController animated:animated];
        }
        else {  // 不存在就创建一个
            navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
            [LCNavigation setRootViewController:navigationController];
        }
    }
}

+(void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *currentVC = [LCNavigation sharedLCNavigation].currentViewController;
    if (currentVC){  // 当前控制器存在, 直接present
        [currentVC presentViewController:viewController animated:animated completion:completion];
    }else{ // 将控制器设为根控制器
        [self setRootViewController:viewController];
    }
}

+(void)popViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated
{
    UINavigationController *currentNavVC = [LCNavigation sharedLCNavigation].currentNavigationViewController;
    if (currentNavVC) {
        NSInteger count = currentNavVC.viewControllers.count;
        if (count > level) {
            [currentNavVC popToViewController:currentNavVC.viewControllers[count-1-level] animated:animated];
        }else{
            NSLog(@"当前导航控制器下共有%ld个子控制器,无法pop%ld个",count,level);
        }
    }
}

+(void)popToRootViewControllerAnimated:(BOOL)animated
{
    UINavigationController *currentNavVC = [LCNavigation sharedLCNavigation].currentNavigationViewController;
    if (currentNavVC) {
        [self popViewControllerWithLevel:currentNavVC.viewControllers.count - 1 animated:animated];
    }
}

+(void)dismissViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *currentVC = [LCNavigation sharedLCNavigation].currentViewController;
    NSInteger srcLevel = level;
    if (currentVC) {
        
        // A modal 显示 B,
        // A 为 presentingViewController  B 为 presentedViewController
        while (level > 0) {
            currentVC = currentVC.presentingViewController;
            if (currentVC) {
                level -= 1;
            }else{
                break;
            }
        }
        // 默认 currentVC 和 current.presentingViewController调用此方法产生的效果一样(只dismiss掉一层)
        // 在presented VC里面调用下面的方法的时候，系统会自动的将这个消息传递到相应的presenting VC中，这样就可以实现不管谁弹出了自己，当不再需要的时候直接将自己消失掉的功能
        [currentVC dismissViewControllerAnimated:animated completion:completion];
    }
    
    if (!currentVC) {
        NSLog(@"您确定可以dismiss%ld个吗",srcLevel);
    }
}

+(void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *currentVC = [LCNavigation sharedLCNavigation].currentViewController;
    
    while (currentVC.presentingViewController) {
        currentVC = currentVC.presentingViewController;
    }
    [currentVC dismissViewControllerAnimated:NSRegularExpressionAnchorsMatchLines completion:completion];
}

#pragma mark - Other
// 通过递归拿到当前控制器
-(UIViewController *)currentViewControllerFrom:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *navVC = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navVC.viewControllers.lastObject];
        
    } // 导航控制器,则返回最后一个
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabVC.selectedViewController];

    } // tabBar 控制器, 则返回选中的一个
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];

    }// 传入的控制器发生modal, 则获取modal的控制器
    return viewController;
}

// 设置为根控制器
+(void)setRootViewController:(UIViewController *)viewController
{
    [UIApplication sharedApplication].keyWindow.rootViewController = viewController;
}



@end




