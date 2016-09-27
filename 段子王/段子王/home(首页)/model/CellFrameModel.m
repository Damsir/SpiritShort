//
//  CellFrameModel.m
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "CellFrameModel.h"

@implementation CellFrameModel

/**
 * 重写set方法，根据拿到的数据计算尺寸
 */

- (void)setDataModel:(CustomCellModel *)dataModel
{
    _dataModel = dataModel;
    
    // 背景View
    _backView_F = CGRectMake(10, 0, SCREEN_W-20, 10);
    
    // 头像
    _userIcon_F = CGRectMake(10, 10, 30, 30);
    
    // 用户名
    _userName_F = CGRectMake(CGRectGetMaxX(_userIcon_F)+10, CGRectGetMinY(_userIcon_F), SCREEN_W-CGRectGetWidth(_userIcon_F)-10, CGRectGetHeight(_userIcon_F));
    
    // 计算内容的高度
    CGRect text_rect = [dataModel.text boundingRectWithSize:CGSizeMake(SCREEN_W-40, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    _text_F = CGRectMake(CGRectGetMinX(_userIcon_F), CGRectGetMaxY(_userIcon_F)+10 , text_rect.size.width, text_rect.size.height+5);

    // 计算宽高比
    CGFloat scale_WH = dataModel.video_height/dataModel.video_width;
    CGFloat video_w = SCREEN_W-40;
    CGFloat video_h = video_w * scale_WH;
    _video_F = CGRectMake(CGRectGetMinX(_userIcon_F), CGRectGetMaxY(_text_F)+10, video_w, video_h);
    
    // 播放按钮
    _play_F = CGRectMake(CGRectGetWidth(_video_F)/2-22.5, CGRectGetHeight(_video_F)/2.0-22.5, 45, 45);
    
    // 蒙版
    _coverView_F = CGRectMake(0, CGRectGetHeight(_video_F)-35, CGRectGetWidth(_video_F), 35);
    
    // 播放次数
    _play_count_F = CGRectMake(5, 0, (CGRectGetWidth(_coverView_F)-10)/2, CGRectGetHeight(_coverView_F));
    
    // 播放时长
    _duration_F = CGRectMake(CGRectGetMaxX(_play_count_F), 0, CGRectGetWidth(_play_count_F), CGRectGetHeight(_play_count_F));
    
    // 点赞
    _digg_count_F = CGRectMake(_userIcon_F.origin.x, CGRectGetMaxY(_video_F)+10, (SCREEN_W-40)/4.0, 30);
    
    // 踩
    _bury_count_F = CGRectMake(CGRectGetMaxX(_digg_count_F), CGRectGetMinY(_digg_count_F), CGRectGetWidth(_digg_count_F), CGRectGetHeight(_digg_count_F));
    
    // 分享
    _share_count_F = CGRectMake(CGRectGetMaxX(_bury_count_F), CGRectGetMinY(_digg_count_F), CGRectGetWidth(_digg_count_F), CGRectGetHeight(_digg_count_F));
    
    // 评论
    _collection_F = CGRectMake(CGRectGetMaxX(_share_count_F), CGRectGetMinY(_digg_count_F), CGRectGetWidth(_digg_count_F), CGRectGetHeight(_digg_count_F));
    
    // 大父容器
    _backView_F.size.height = CGRectGetMaxY(_digg_count_F)+10;
    
    
    // cell的总高度
    _cell_height = _backView_F.size.height;

}



@end













