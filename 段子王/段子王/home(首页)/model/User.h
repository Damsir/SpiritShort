//
//  User.h
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "JSONModel.h"

@interface User : JSONModel

/**
 * 用户信息
 */
@property (nonatomic, strong) NSNumber *user_verified;
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSNumber *is_following;
@property (nonatomic, copy) NSString *name;


@end
