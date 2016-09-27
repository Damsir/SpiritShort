//
//  DKTabBarController.m
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "DKTabBarController.h"
#import "HomeViewController.h"
#import "DKNavigationController.h"
#import "MineViewController.h"



@interface DKTabBarController ()

@end

@implementation DKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 首页
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addController:home andWithTitle:@"精段子" andWithImage:@"tabbar_home" andWithSeleImage:@"tabbar_home_selected"];
    

     MineViewController *mineVC = [[MineViewController alloc] init];
    [self addController:mineVC andWithTitle:@"我的" andWithImage:@"radar_icon_people" andWithSeleImage:@"radar_icon_people_selected"];
}

/**
 * 设置子控制器样式
 */
- (void)addController:(UIViewController *)child andWithTitle:(NSString *)title andWithImage:(NSString *)image andWithSeleImage:(NSString *)seleImage
{
    
    child.tabBarItem.title = title;
    
    // 设置字体颜色
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = MAIN_COLOR;
    [child.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateSelected];
    
    // 设置图片正常颜色显示
    child.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    child.tabBarItem.selectedImage = [[UIImage imageNamed:seleImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    // 把ViewController包装成导航控制器
    DKNavigationController *nav = [[DKNavigationController alloc] init];
    [nav addChildViewController:child];
    
    
    [self addChildViewController:nav];
    
}


@end
