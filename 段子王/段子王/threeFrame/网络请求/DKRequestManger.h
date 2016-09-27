//
//  DKRequestManger.h
//  网络请求
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKRequest.h"


@interface DKRequestManger : NSObject


// 对请求在封装一次(类方法)
+ (void)requsetWithUrl:(NSString *)urlStr success:(successRequset)success fail:(failRequset)fail;


// 对请求类方法封装，请求是否添加缓存
+ (void)requsetWithCache:(BOOL)isCache WithUrl:(NSString *)urlStr success:(successRequset)success fail:(failRequset)fail;


@end

