//
//  VideoCover.m
//  段子王
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "VideoCover.h"

@implementation VideoCover

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"url":@"videoUrl"}];
    return mapper;
}


@end
