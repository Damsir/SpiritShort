//
//  LargeImage.h
//  段子王
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "JSONModel.h"

@protocol LargeImage
@end

@interface LargeImage : JSONModel
/**
 * 图片的信息
 */
@property(nonatomic, strong) NSString *imageUrl;
@property(nonatomic, assign) NSInteger image_W;
@property(nonatomic, assign) NSInteger image_H;

@end
