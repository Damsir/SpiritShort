//
//  CustomCellModel.h
//  段子王
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "JSONModel.h"
#import "DKDataInfo.h"

@interface CustomCellModel : JSONModel

/**
 * 拿到网络请求回来的数据
 */
@property(nonatomic, strong) DKDataInfo *dataInfo;

/**
 * 类型
 */
@property(nonatomic, strong) NSString *category_name;

/**
 * 用户信息
 */
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSString *userIcon;
@property(nonatomic, strong) NSString *text;

/**
 * 视频
 */
@property(nonatomic, strong) NSString *video;
@property(nonatomic, strong) NSString *video_cover;
@property(nonatomic, assign) CGFloat video_width;
@property(nonatomic, assign) CGFloat video_height;
@property(nonatomic, strong) NSString *play_count;
@property(nonatomic, strong) NSString *duration;

/**
 * 图片
 */
@property(nonatomic, strong) NSString *image;
@property(nonatomic, assign) CGFloat image_width;
@property(nonatomic, assign) CGFloat image_height;

/**
 * 赞、踩、收藏、分享
 */
@property(nonatomic, strong) NSString *digg_count;
@property(nonatomic, strong) NSString *bury_count;
@property(nonatomic, strong) NSString *collection;
@property(nonatomic, strong) NSString *share_count;

@end
