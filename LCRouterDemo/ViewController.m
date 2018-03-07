//
//  ViewController.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/2.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "ViewController.h"
#import "LCRouter.h"
#import "UIViewController+LCRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 测试push
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"push_TwoViewController" forState:0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 100, 100, 44);
        [btn sizeToFit];
        btn.tag = 100;
        btn;
    })];
    
    // 测试present
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"present_FourViewController" forState:0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 144 + 20, 100, 44);
        [btn sizeToFit];
        btn.tag = 101;
        btn;
    })];
    
//    [self testURL];
    
    [self testLCNotification];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"oneVC_childNaVC:%@",self.navigationController.childViewControllers);
}

-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:   // push
        {
            // 从plist文件中匹配
            [LCRouter pushURLString:@"maris://twoitem" params:@{@"array" : @[@"a",@"b",@"c"]} animated:true];
            // 直接匹配
//            [LCRouter pushURLString:@"TwoViewController" params:@{@"array" : @[@"a",@"b",@"c"]} animated:true];
            
            // 跳转后
            UIViewController *twoVC = [LCRouter sharedLCRouter].currentViewController;
            [twoVC setValueBlock:^(id value) {
                NSLog(@"vc:block==>%@",value);
            }];
            
            break;
        }
        case 101:   // present
        {
            [LCRouter presentURLString:@"FourViewController" params:nil animated:true completion:nil];
            break;
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [LCRouter sharedLCRouter].currentViewController;
    NSLog(@"当前vc:%@",vc);
    
    [LCRouter openURLString:@"maris://catagory/travel" withParams:@{@"name" : @"helloWorld"} completion:^(id result) {
        NSLog(@"result:==>%@",result);
    }];
    
    // 取消注册,类似于通知里面的 取消通知
//    [LCRouter deregisterURLString:@"lili"];
}

#pragma mark - Test URL
-(void)testURL
{
    NSString *urlStr = @"viewController"; // http://www.baidu.com?id=10086
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *home = [NSString stringWithFormat:@"%@://%@%@", url.scheme, url.host,url.path];
    NSLog(@"==>%@\n==>%@\n==>%@\n==>%@",url.scheme,url.host,url.path,home);
}

-(void)testLCNotification
{
    [LCRouter registerURLString:@"maris://catagory/travel" handler:^(NSDictionary *params) {
        NSLog(@"params:%@",params);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            void(^completion)(id result) = params[@"LCRouterParameterCompletion"];
            if (completion) {
                completion(@"我在openUrl");
            }
        });
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
