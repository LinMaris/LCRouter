//
//  LCRouter.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/2.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "LCRouter.h"
#import "LCNavigation.h"
#import "UIViewController+LCRouter.h"
#import "LCNotification.h"

@interface LCRouter()
/** 存储读取的plist文件数据 */
@property(nonatomic,strong) NSDictionary *configDict;

@end

@implementation LCRouter

LCSingletonM(LCRouter)

+(void)loadConfigDictFromPlist:(NSString *)pistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:pistName ofType:nil];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (configDict) {
        [LCRouter sharedLCRouter].configDict = configDict;
    }else {
        NSLog(@"请按照说明添加对应的plist文件");
    }
}

+(void)pushURLString:(NSString *)urlString params:(NSDictionary*)param animated:(BOOL)animated
{
    UIViewController *targetVC = [UIViewController initFromString:urlString withParam:param fromConfig:[LCRouter sharedLCRouter].configDict];
    if (targetVC) {
        [LCNavigation pushViewController:targetVC animated:animated];
    }else{
        NSLog(@"此url对应的控制器不存在==>%@",urlString);
    }
}

+(void)presentURLString:(NSString *)urlString params:(NSDictionary *)param animated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *targetVC = [UIViewController initFromString:urlString withParam:param fromConfig:[LCRouter sharedLCRouter].configDict];
    if (targetVC) {
        [LCNavigation presentViewController:targetVC animated:animated completion:completion];
    }else{
        NSLog(@"此url对应的控制器不存在==>%@",urlString);
    }
    
}

+(void)popViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated
{
    [LCNavigation popViewControllerWithLevel:level animated:animated];
}
+(void)popToRootViewControllerAnimated:(BOOL)animated
{
    [LCNavigation popToRootViewControllerAnimated:animated];
}

+(void)dismissViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated completion:(void (^)(void))completion
{
    [LCNavigation dismissViewControllerWithLevel:level animated:animated completion:completion];
}

+(void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
{
    [LCNavigation dismissToRootViewControllerAnimated:animated completion:completion];
}

-(UIViewController *)currentViewController
{
    return [LCNavigation sharedLCNavigation].currentViewController;
}

-(UIViewController *)currentNavigationViewController
{
    return [LCNavigation sharedLCNavigation].currentNavigationViewController;
}

#pragma mark - LCNotification
+(void)registerURLString:(NSString *)urlString handler:(void(^)(NSDictionary  *params))handler
{
    [LCNotification registerURLString:urlString handler:handler];
}

+ (void)openURLString:(NSString *)urlString withParams:(NSDictionary *)params completion:(void (^)(id result))completion
{
    [LCNotification openURLString:urlString withParams:params completion:completion];
}

+(void)deregisterURLString:(NSString *)urlString
{
    [LCNotification deregisterURLPattern:urlString];
}

@end
