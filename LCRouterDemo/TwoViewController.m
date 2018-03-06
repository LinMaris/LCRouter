//
//  TwoViewController.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/3.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "TwoViewController.h"
#import "UIViewController+LCRouter.h"
#import "LCRouter.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TwoViewController";
    self.view.backgroundColor = [UIColor orangeColor];
    // 若不设置backgroundColor,则在有跳转动画的时候,会出现莫名卡顿
    
    NSLog(@"self.params: %@",self.params);
    UIViewController *vc = [LCRouter sharedLCRouter].currentViewController;
    NSLog(@"跳转后2:%@",vc);
    
    self.valueBlock(@[@"hello,world",@"I'm TwoViewController"]);
    
    [self testPop];
}

-(void)testPop
{
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"push_ThreeViewController" forState:0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 100, 100, 44);
        [btn sizeToFit];
        btn.tag = 100;
        btn;
     })];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"pop_ViewController" forState:0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 144 + 20, 100, 44);
        [btn sizeToFit];
        btn.tag = 101;
        btn;
    })];
}

-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        [LCRouter pushURLString:@"ThreeViewController" params:nil animated:true];
    }else if (sender.tag == 101){
        [LCRouter popViewControllerWithLevel:1 animated:true];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
