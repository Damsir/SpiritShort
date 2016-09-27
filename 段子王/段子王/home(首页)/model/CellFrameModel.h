//
//  CellFrameModel.h
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomCellModel.h"

@interface CellFrameModel : NSObject

// 数据源
@property(nonatomic, strong) CustomCellModel *dataModel;

/**
 * 根据数据计算尺寸
 */
@property(nonatomic, assign) CGRect backView_F;
@property(nonatomic, assign) CGRect coverView_F;
@property(nonatomic, assign) CGRect userName_F;
@property(nonatomic, assign) CGRect userIcon_F;
@property(nonatomic, assign) CGRect text_F;
@property(nonatomic, assign) CGRect video_F;
@property(nonatomic, assign) CGRect play_F;
@property(nonatomic, assign) CGRect play_count_F;
@property(nonatomic, assign) CGRect duration_F;
@property(nonatomic, assign) CGRect digg_count_F;
@property(nonatomic, assign) CGRect bury_count_F;
@property(nonatomic, assign) CGRect collection_F;
@property(nonatomic, assign) CGRect share_count_F;

/**
 * cell的总高度
 */
@property(nonatomic, assign) CGFloat cell_height;

@end
