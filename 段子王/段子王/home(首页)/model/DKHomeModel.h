//
//  DKHomeModel.h
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "JSONModel.h"
#import "DKDataInfo.h"

@interface DKHomeModel : JSONModel


@property(nonatomic, strong) NSString *tip;
@property(nonatomic, strong) NSString *has_new_message;

/**
 * group对象数组
 */
@property(nonatomic, strong) NSArray<DKDataInfo> *data;


@end
