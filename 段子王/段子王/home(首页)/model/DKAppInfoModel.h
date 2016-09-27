//
//  DKAppInfoModel.h
//  段子王
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "JSONModel.h"
#import "DKHomeModel.h"


typedef void (^refreshDataBlock)(BOOL isSuccess,NSError *error);

@interface DKAppInfoModel : JSONModel


@property(nonatomic, strong) DKHomeModel *homeModel;


- (void)loadDataWithBlock:(refreshDataBlock)block;

- (void)loadMoreDataBlock:(refreshDataBlock)block;

@end
