//
//  ThreeViewController.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/4.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "ThreeViewController.h"
#import "LCRouter.h"
#import "UIViewController+LCRouter.h"

@interface ThreeViewController ()
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ThreeViewController";
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self testPop];
    
    NSLog(@"ThreeViewController:%@",self.params);
    
    NSLog(@"threeVC_childNaVC:%@",self.navigationController.childViewControllers);
    
    [self testMutableDic];
}

-(void)testPop
{
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"pop_RootViewController" forState:0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 144 + 20, 100, 44);
        [btn sizeToFit];
        btn.tag = 101;
        btn;
    })];
}

-(void)btnClick:(UIButton *)sender
{
    [LCRouter popToRootViewControllerAnimated:true];
}

-(void)testMutableDic
{
    NSMutableDictionary *routes = [NSMutableDictionary dictionary];
    NSDictionary *subDic = routes;
    
    [subDic setValue:@"hello" forKey:@"-"];
    NSLog(@"1==>%p",routes);
    NSLog(@"2==>%p",subDic);
    // subDic 和 self.routes 的内存地址相同,无论subDic 是NSDictionary还是 NSMutableDictionary
    // 结论: 可变字典 在增加键值对时,对象不变,只操作同一份内存区域
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
