//
//  DKHomeModel.m
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "DKHomeModel.h"

@implementation DKHomeModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"data.has_new_message":@"has_new_message",@"data.tip":@"tip",@"data.data":@"data"}];
    return mapper;
}

@end
