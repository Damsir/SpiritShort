//
//  UIView+DKSize.h
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DKSize)
/**
 * 位置
 */
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;
@property(nonatomic, assign) CGPoint origin;

/**
 * 尺寸
 */
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGSize size;

@end
