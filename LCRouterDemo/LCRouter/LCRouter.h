//
//  LCRouter.h
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/2.
//  Copyright © 2018年 林川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LCSingleton.h"


@interface LCRouter : NSObject
/** 单例 */
LCSingletonH(LCRouter)

/**
 *  加载plist文件中的URL配置信息
 *
 *  @param pistName plist文件名称,不用加后缀
 */
+ (void)loadConfigDictFromPlist:(NSString *)pistName;

#pragma mark --------  拿到导航控制器 和当前控制器 --------

/** 返回当前控制器 */
-(UIViewController *)currentViewController;

/** 返回当前控制器的导航控制器 */
-(UIViewController *)currentNavigationViewController;

#pragma mark --------  push 与 pop --------
/**
    push 控制器
 */
+(void)pushURLString:(NSString *)urlString params:(NSDictionary*)param animated:(BOOL)animated;

/**
    pop 控制器
    @param level 需要pop到哪一层,上一层就是 1, 上两层就是 2
 */
+(void)popViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;
+(void)popToRootViewControllerAnimated:(BOOL)animated;

#pragma mark --------  present 与 dismiss --------
/**
    modal 控制器
 */
+(void)presentURLString:(NSString *)urlString params:(NSDictionary *)param animated:(BOOL)animated completion:(void(^)(void))completion;

/**
    dismiss 控制器
 */
+(void)dismissViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated completion:(void(^)(void))completion;;
+(void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;;

#pragma mark --------  类似Notification --------
/**
    注册 URL
 */
+(void)registerURLString:(NSString *)urlString handler:(void(^)(NSDictionary  *params))handler;

/**
    开启
 */
+ (void)openURLString:(NSString *)urlString withParams:(NSDictionary *)params completion:(void (^)(id result))completion;

/**
    取消注册
 */
+(void)deregisterURLString:(NSString *)urlString;

@end
