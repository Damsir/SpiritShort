//
//  CustomHomeCell.h
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellFrameModel.h"
#import "CustomCellModel.h"

@protocol CustomHomeCellDelegate <NSObject>

- (void)clickDiggInSection:(NSInteger)section;//赞
- (void)clickBuryInSection:(NSInteger)section;//踩
- (void)showShareView;//分享
- (void)playVideoWithView:(UIView *)view andWithImage:(UIImage *)img andWithUrl:(NSString *)url;//播放
- (void)changeSourceData:(NSString *)str inSection:(NSInteger)section;


@end


@interface CustomHomeCell : UITableViewCell

@property(nonatomic, assign) NSInteger section;

/**
 * 需要显示的控件
 */
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIImageView *coverView;

@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UIImageView *userIcon;
@property(nonatomic, strong) UILabel *text;
@property(nonatomic, strong) UIImageView *video;
@property(nonatomic, strong) UILabel *play_count;
@property(nonatomic, strong) UILabel *duration;
@property(nonatomic, strong) UIButton *digg_count;
@property(nonatomic, strong) UIButton *bury_count;
@property(nonatomic, strong) UIButton *collection;//收藏
@property(nonatomic, strong) UIButton *share_count;
@property(nonatomic, strong) UIButton *play;

/**
 * 代理
 */
@property(nonatomic, assign) id<CustomHomeCellDelegate> delegate;

/**
 * 计算回来的尺寸
 */
@property(nonatomic, strong) CellFrameModel *frameModel;

/**
 * 显示数据
 */
- (void)setUIWithDataModel:(CustomCellModel *)dataModel;



@end



