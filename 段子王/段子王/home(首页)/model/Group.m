//
//  Group.m
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "Group.h"

@implementation Group
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"medium_cover.url_list":@"videoCover",@"large_image_list":@"largeImage"}];
    return mapper;
}

@end
