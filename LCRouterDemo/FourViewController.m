//
//  FourViewController.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/4.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "FourViewController.h"
#import "LCRouter.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FourViewController";
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"dismiss_ViewController" forState:0];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 100, 100, 44);
        [btn sizeToFit];
        btn;
    })];
}

-(void)btnClick
{
    // level 为 1 或者 0,均表示dismiss掉当前vc
//    [LCRouter dismissViewControllerWithLevel:1 animated:true completion:nil];
    
    [LCRouter dismissToRootViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
