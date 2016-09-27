//
//  LargeImage.m
//  段子王
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "LargeImage.h"

@implementation LargeImage

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"url":@"imageUrl",@"height":@"image_H",@"width":@"image_W"}];
    return mapper;
}


@end
