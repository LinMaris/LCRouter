//
//  LCNotification.h
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/5.
//  Copyright © 2018年 林川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCSingleton.h"

@interface LCNotification : NSObject

LCSingletonH(LCNotification)

typedef void (^LCRouterHandler)(NSDictionary *routerParameters);

+(void)registerURLString:(NSString *)urlString handler:(LCRouterHandler)handler;

+ (void)openURLString:(NSString *)urlString withParams:(NSDictionary *)params completion:(void (^)(id result))completion;

+ (void)deregisterURLPattern:(NSString *)URLPattern;

@end
