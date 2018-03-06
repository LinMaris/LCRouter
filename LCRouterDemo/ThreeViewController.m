//
//  ThreeViewController.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/4.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "ThreeViewController.h"
#import "LCRouter.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ThreeViewController";
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self testPop];
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
