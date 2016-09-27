//
//  CustomCellModel.m
//  段子王
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "CustomCellModel.h"

@implementation CustomCellModel

/**
 * 根据网络请求回来的数据，设置cell需要显示的数据
 */

- (void)setDataInfo:(DKDataInfo *)dataInfo
{
    _dataInfo = dataInfo;
    _category_name = dataInfo.group.category_name;
    
    /**
     * 用户信息
     */
    _userName = dataInfo.group.user.name;
    _userIcon = dataInfo.group.user.avatar_url;
    _text = dataInfo.group.text;
    
    
    /**
     * 视频
     */
    _video = dataInfo.group.mp4_url;
    _video_cover = [dataInfo.group.videoCover[0] videoUrl];
    _video_width = dataInfo.group.video_width.floatValue;
    _video_height = dataInfo.group.video_height.floatValue;
    _play_count = dataInfo.group.play_count;
    _duration = dataInfo.group.duration;
    
    /**
     * 图片
     */
    _image_width = [dataInfo.group.largeImage[0] image_W];
    _image_height = [dataInfo.group.largeImage[0] image_H];
    
    
    /**
     * 赞、踩、评论、分享
     */
    _digg_count = dataInfo.group.digg_count;
    _bury_count = dataInfo.group.bury_count;
    _collection = dataInfo.group.comment_count;
    _share_count = dataInfo.group.share_count;
    
}

@end

