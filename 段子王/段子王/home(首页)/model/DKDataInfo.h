//
//  DKDataInfo.h
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "JSONModel.h"
#import "Group.h"
#import "CommentInfo.h"
#import "AdModel.h"

@protocol DKDataInfo
@end

@interface DKDataInfo : JSONModel


@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *display_time;
@property(nonatomic, strong) NSString *online_time;

/**
 * 基本数据信息
 */
@property(nonatomic, strong) Group *group;

/**
 * 评论数组
 */
@property(nonatomic, strong) NSArray<CommentInfo> *comments;

/**
 * 广告
 */
@property(nonatomic, strong) AdModel *ad;

@end
