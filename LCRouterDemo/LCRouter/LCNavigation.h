//
//  LCNavigation.h
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/3.
//  Copyright © 2018年 林川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LCSingleton.h"

@interface LCNavigation : NSObject

LCSingletonH(LCNavigation)

/** 返回当前控制器 */
-(UIViewController*)currentViewController;

/** 返回当前的导航控制器 */
-(UINavigationController*)currentNavigationViewController;

+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

+(void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion;

+(void)popViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;
+(void)popToRootViewControllerAnimated:(BOOL)animated;

+(void)dismissViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated completion:(void(^)(void))completion;
+(void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;

// 将URL 参数 转化为字典
- (NSDictionary *)paramsURL:(NSURL *)url;

@end
