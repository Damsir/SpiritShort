//
//  VideoCover.h
//  段子王
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "JSONModel.h"

@protocol VideoCover
@end


@interface VideoCover : JSONModel

@property(nonatomic, strong) NSString *videoUrl;

@end
