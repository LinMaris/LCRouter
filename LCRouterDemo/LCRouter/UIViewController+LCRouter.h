//
//  UIViewController+LCRouter.h
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/3.
//  Copyright © 2018年 林川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LCRouter)

/** 跳转后控制器能拿到的url */
@property(nonatomic, strong) NSURL *originUrl;

/** url路径 */
@property(nonatomic,copy) NSString *path;

/** 跳转后控制器能拿到的参数 */
@property(nonatomic,strong) NSDictionary *params;

/** 回调Block */
@property(nonatomic,copy) void(^valueBlock)(id value);

// 根据参数创建控制器
+ (UIViewController *)initFromString:(NSString *)urlString withParam:(NSDictionary *)param fromConfig:(NSDictionary *)configDict;

@end
