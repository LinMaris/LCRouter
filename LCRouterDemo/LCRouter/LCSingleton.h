//
//  LCSingleton.h
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/2.
//  Copyright © 2018年 林川. All rights reserved.
//

// .h文件
#define LCSingletonH(name) + (instancetype)shared##name;

// .m文件
#define LCSingletonM(name) \
static id _instacnce;\
\
+ (instancetype)shared##name\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instacnce = [[self alloc] init];\
    });\
    return _instacnce;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instacnce = [super allocWithZone:zone];\
    });\
    return _instacnce;\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
    return _instacnce;\
}\
