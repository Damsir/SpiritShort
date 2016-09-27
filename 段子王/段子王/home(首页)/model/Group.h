//
//  Group.h
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "JSONModel.h"
#import "User.h"
#import "VideoCover.h"
#import "LargeImage.h"

@protocol Group
@end

@interface Group : JSONModel
// 内容
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *text;

// 视频及尺寸
@property(nonatomic, strong) NSString *mp4_url;
@property(nonatomic, strong) NSNumber *video_height;
@property(nonatomic, strong) NSNumber *video_width;

// 类型
@property(nonatomic, strong) NSString *is_video;
@property(nonatomic, strong) NSString *category_name;

//  时长
@property(nonatomic, strong) NSString *duration;
// 播放次数
@property(nonatomic, strong) NSString *play_count;
// 评论数
@property(nonatomic, strong) NSString *comment_count;
// 分享数
@property(nonatomic, strong) NSString *share_count;
// 赞次数
@property(nonatomic, strong) NSString *digg_count;
// 踩次数
@property(nonatomic, strong) NSString *bury_count;

/**
 * 用户信息
 */
@property(nonatomic, strong) User *user;

/**
 * 视频预览图
 */
@property(nonatomic, strong) NSArray<VideoCover> *videoCover;

/**
 * 图片信息
 */
@property(nonatomic, strong) NSArray<LargeImage> *largeImage;

@end








