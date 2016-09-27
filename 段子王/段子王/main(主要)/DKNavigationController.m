//
//  DKNavigationController.m
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "DKNavigationController.h"

@interface DKNavigationController ()

@end

@implementation DKNavigationController


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 当push的时候判断，如果栈里面大于0个元素，隐藏tabbar
    if (self.viewControllers.count>0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置返回按钮样式
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    }
    // 后调用父类的方法
    [super pushViewController:viewController animated:animated];
}

/**
 * 返回按钮点击事件
 */
- (void)backClick
{
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end








