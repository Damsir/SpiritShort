//
//  BaseViewController.m
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-49) style:UITableViewStyleGrouped];

    self.table.delegate = self;
    self.table.dataSource = self;
    
    [self.view addSubview:self.table];
    
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"like"];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.tabBarController.tabBar.translucent = NO;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}











@end



