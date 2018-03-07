//
//  BaseNavigationController.m
//  LCRouterDemo
//
//  Created by 林川 on 2018/3/4.
//  Copyright © 2018年 林川. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 第一次push进RootViewController,此时子vc数目为0
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = true;
    }
    [super pushViewController:viewController animated:animated];
    // push进RootViewController,此时此时子vc数目为1
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
