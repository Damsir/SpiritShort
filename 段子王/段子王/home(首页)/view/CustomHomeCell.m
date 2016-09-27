//
//  CustomHomeCell.m
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "CustomHomeCell.h"

#import "DBManager.h"//收藏

@interface CustomHomeCell ()<UIAlertViewDelegate>

@end

@implementation CustomHomeCell

/**
 * 1.创建UI控件
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       
        // 背景视图
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        
        // 用户昵称
        _userName = [[UILabel alloc] init];
        _userName.font = [UIFont systemFontOfSize:13];
        [_backView addSubview:_userName];
        
        // user的头像
        _userIcon = [[UIImageView alloc] init];
        _userIcon.layer.cornerRadius = 15;
        _userIcon.layer.masksToBounds = YES;
        [_backView addSubview:_userIcon];
        
        // 内容
        _text = [[UILabel alloc] init];
        _text.numberOfLines = 0;
        _text.font = [UIFont systemFontOfSize:13];
        [_backView addSubview:_text];
        
        // 视频
        _video = [[UIImageView alloc] init];
        _video.userInteractionEnabled = YES;
        [_backView addSubview:_video];
        
        // 播放按钮
        _play = [[UIButton alloc] init];
        [_play setImage:[UIImage imageNamed:@"大播放图标"] forState:UIControlStateNormal];
        [_play addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        [_video addSubview:_play];
        
        
        // 播放次数和时长后面的蒙版
        _coverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fooddetailbg_"]];
        [_video addSubview:_coverView];
        
        // 播放次数
        _play_count = [[UILabel alloc] init];
        _play_count.textColor = [UIColor whiteColor];
        _play_count.textAlignment = NSTextAlignmentLeft;
        _play_count.font = [UIFont systemFontOfSize:13];
        [_coverView addSubview:_play_count];
        
        // 播放时长
        _duration = [[UILabel alloc] init];
        _duration.textColor = [UIColor whiteColor];
        _duration.textAlignment = NSTextAlignmentRight;
        _duration.font = [UIFont systemFontOfSize:13];
        [_coverView addSubview:_duration];
        
        // 点赞数
        _digg_count = [[UIButton alloc] init];
        [_digg_count addTarget:self action:@selector(diggClick:) forControlEvents:UIControlEventTouchUpInside];
        [_digg_count setImage:[UIImage imageNamed:@"Praise_pop"] forState:UIControlStateNormal];
        [_digg_count setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _digg_count.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _digg_count.titleLabel.font = [UIFont systemFontOfSize:12];
        [_backView addSubview:_digg_count];
        
        // 踩次数
        _bury_count = [[UIButton alloc] init];
        [_bury_count addTarget:self action:@selector(buryClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bury_count setImage:[UIImage imageNamed:@"step_pop"] forState:UIControlStateNormal];
        [_bury_count setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _bury_count.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _bury_count.titleLabel.font = [UIFont systemFontOfSize:12];
        [_backView addSubview:_bury_count];
        
        // 分享数
        _share_count = [[UIButton alloc] init];
        [_share_count addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];// moreicon_textpage
        [_share_count setImage:[UIImage imageNamed:@"moreicon_textpage"] forState:UIControlStateNormal];
        [_share_count setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _share_count.titleEdgeInsets = UIEdgeInsetsMake(0,-10, 0, 0);
        _share_count.titleLabel.font = [UIFont systemFontOfSize:12];
        [_backView addSubview:_share_count];
        
        // 收藏
        _collection = [[UIButton alloc] init];
        [_collection setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
        [_collection setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _collection.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _collection.titleLabel.font = [UIFont systemFontOfSize:12];
        [_collection addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_collection];
 
    }
    return self;
}

/**
 * 2.设置尺寸
 */
- (void)setFrameModel:(CellFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    /**给每个控件设置尺寸*/
    
    _backView.frame = frameModel.backView_F;
    
    _coverView.frame = frameModel.coverView_F;
    
    _userName.frame = frameModel.userName_F;
    
    _userIcon.frame = frameModel.userIcon_F;
    
    _text.frame = frameModel.text_F;
    
    _video.frame = frameModel.video_F;
    
    _play.frame = frameModel.play_F;
    
    _play_count.frame = frameModel.play_count_F;
    
    _duration.frame = frameModel.duration_F;
    
    _digg_count.frame = frameModel.digg_count_F;
    
    _bury_count.frame = frameModel.bury_count_F;
    
    _collection.frame = frameModel.collection_F;
    
    _share_count.frame = frameModel.share_count_F;
    
}

/**
 * 3.设置UI
 */
- (void)setUIWithDataModel:(CustomCellModel *)dataModel
{
    self.userName.text = dataModel.userName;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:dataModel.userIcon]];
    self.text.text = dataModel.text;
    [self.video sd_setImageWithURL:[NSURL URLWithString:dataModel.video_cover] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    [self.digg_count setTitle:dataModel.digg_count forState:UIControlStateNormal];
    [self.bury_count setTitle:dataModel.bury_count forState:UIControlStateNormal];
    [self.collection setTitle:dataModel.collection forState:UIControlStateNormal];
    [self.share_count setTitle:dataModel.share_count forState:UIControlStateNormal];
    // 播放次数和时间
    [self setPlayCount:dataModel.play_count andWithDuration:dataModel.duration];
}

#pragma mark -- 收藏事件
-(void)collectClick:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"收藏"])
    {
        //收藏成功改变图片
        [btn setTitle:@"已收藏" forState:UIControlStateNormal];
        
        NSArray *array = [[DBManager sharedDBManager] recieveDBData];
        //NSLog(@"dbARray:%@",array);
        if (array.count == 0)
        {
            //NSLog(@"====-%@; %@ ; %@",self.frameModel.dataModel.video,self.frameModel.dataModel.video_cover,self.frameModel.dataModel.text);
            //收藏
            NSDictionary *dataDic = @{@"url":self.frameModel.dataModel.video,@"text":self.frameModel.dataModel.text ,@"video_cover":self.frameModel.dataModel.video_cover,@"video":self.frameModel.dataModel.video};
            [[DBManager sharedDBManager] insertDataWithDictionary:dataDic];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        }
        else
        {
            for (int i=0; i<array.count; i++)
            {
                NSDictionary *oldDic = array[i];
                if ([oldDic[@"video"] isEqualToString:self.frameModel.dataModel.video])
                {
                    NSLog(@"====--%@",oldDic[@"video"]);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经在您的收藏夹里了哦!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                else if(i==array.count-1)
                {
                    //收藏
                    NSDictionary *dataDic = @{@"url":self.frameModel.dataModel.video,@"text":self.frameModel.dataModel.text ,@"video_cover":self.frameModel.dataModel.video_cover,@"video":self.frameModel.dataModel.video};
                    [[DBManager sharedDBManager] insertDataWithDictionary:dataDic];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                }
            }
        }

    }
    
}

/**
 * 播放次数和时间
 */
- (void)setPlayCount:(NSString *)playCount andWithDuration:(NSString *)duration
{
    // 设置可变字体
    NSString *count = [NSString stringWithFormat:@"%@次播放",playCount];
    NSRange range = NSMakeRange(0, count.length-3);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:count];
    [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:range];
    _play_count.attributedText = attr;
    
    // 设置时间格式
    NSInteger time = duration.intValue;
    if (time >= 60)
    {
        NSInteger m = time/60;
        NSInteger s = time%60;
        
        _duration.text = [NSString stringWithFormat:@"%02ld:%02ld",m,s];
    }
    else
    {
        _duration.text = [NSString stringWithFormat:@"00:%02ld",time];
    }
 
}


#pragma mark ---- 分享事件
- (void)share:(UIButton *)share
{
    DKLog(@"share--%ld",self.section);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(showShareView)]) {
        [self.delegate showShareView];
    }
    
}
#pragma mark ---- 点赞事件
- (void)diggClick:(UIButton *)digg
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDiggInSection:)]) {
        [self.delegate clickDiggInSection:self.section];
    }
}
#pragma mark ---- 差评事件
- (void)buryClick:(UIButton *)bury
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBuryInSection:)]) {
        [self.delegate clickBuryInSection:self.section];
    }
}

#pragma mark ---- 播放按钮事件
- (void)playVideo:(UIButton *)play
{
    UIImageView *imageView = (UIImageView *)play.superview;
    UIImage *img = imageView.image;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoWithView: andWithImage:andWithUrl:)])
    {
        [self.delegate playVideoWithView:play.superview andWithImage:img andWithUrl:self.frameModel.dataModel.video];
    }
    
}



@end














