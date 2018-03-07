//
//  UIViewController+LCRouter.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/3.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "UIViewController+LCRouter.h"
#import <objc/runtime.h>

static char LCOriginUrl;
static char LCPath;
static char LCParams;
static char LCBlock;

@implementation UIViewController (LCRouter)

+(UIViewController *)initFromString:(NSString *)urlString withParam:(NSDictionary *)param fromConfig:(NSDictionary *)configDict
{
    // 支持对中文字符的编码
    NSString *encodeStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [UIViewController initFromURL:[NSURL URLWithString:encodeStr] withParam:param fromConfig:configDict];
}

+ (UIViewController *)initFromURL:(NSURL *)url withParam:(NSDictionary *)param fromConfig:(NSDictionary *)configDict
{
    UIViewController *targetVC;
    NSMutableString *homeStr = [NSMutableString string];
    if (url.scheme == nil && url.host == nil) {  // 常规字符串,@"oneVC", @"twoVC"
        url.path ? [homeStr appendString:url.path] : nil;
        
    }else{  // 按照url格式拼接
        [homeStr appendFormat:@"%@://%@", url.scheme, url.host];
        url.path ? [homeStr appendString:url.path] : nil;
    }
    
    Class class = nil;
    if ([configDict.allKeys containsObject:url.scheme]) { // 字典中的所有key是否包含传入的协议头
        id config = configDict[url.scheme];
        
        if ([config isKindOfClass:[NSString class]]) {  // 为 http, https
            class = NSClassFromString(config);
            
        }else if([config isKindOfClass:[NSDictionary class]]) { // 自定义url
            NSDictionary *dict = (NSDictionary *)config;
            
            if ([dict.allKeys containsObject:homeStr]){
                class = NSClassFromString(dict[homeStr]);  // 获取控制器
                if (class == nil) { // // 兼容swift,字符串转类名的时候前面加上命名空间
                    NSString *spaceName = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
                    class =  NSClassFromString([NSString stringWithFormat:@"%@.%@",spaceName,[dict objectForKey:homeStr]]);
                }
            }
        }
    }else {   // 常规字符串 -> vc
        class = NSClassFromString(homeStr);
    }
    
    if (class != nil) {
        targetVC = [[class alloc] init];
        if([targetVC respondsToSelector:@selector(open:withQuery:)]){
            [targetVC open:url withQuery:param];  // 将 param 与 vc 绑定
        }
        
        // 处理网络地址的情况
        if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
            class =  NSClassFromString([configDict objectForKey:url.scheme]);
            targetVC.params = @{@"urlStr": [url absoluteString]};
        }
    }
    return targetVC;
}

#pragma mark - Other
- (void)open:(NSURL *)url withQuery:(NSDictionary *)query{
    self.path = [url path];
    self.originUrl = url;
    if (query) {   // 如果自定义url后面有拼接参数,而且又通过query传入了参数,那么优先query传入了参数
        self.params = query;
    }
}

#pragma mark 参数
-(void)setPath:(NSString *)path
{
    objc_setAssociatedObject(self, &LCPath, path, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setParams:(NSDictionary *)params
{
    objc_setAssociatedObject(self, &LCParams, params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setOriginUrl:(NSURL *)originUrl
{
    objc_setAssociatedObject(self, &LCOriginUrl, originUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setValueBlock:(void (^)(id))valueBlock
{
    objc_setAssociatedObject(self, &LCBlock, valueBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)path
{
    return objc_getAssociatedObject(self, &LCPath);
}
-(NSDictionary *)params
{
    return objc_getAssociatedObject(self, &LCParams);
}
-(NSURL *)originUrl
{
    return objc_getAssociatedObject(self, &LCOriginUrl);
}
-(void (^)(id))valueBlock
{
    return objc_getAssociatedObject(self, &LCBlock);
}

@end
