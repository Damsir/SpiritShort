//
//  BaseViewController.h
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, assign) CGFloat tableOffSetY;

@end
