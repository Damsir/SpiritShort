//
//  DKRequest.h
//  网络请求
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^successRequset)(NSData *data);

typedef void (^failRequset)(NSError *error);

// typedef定义的Block和属性定义的Block区别在于直接定义属性的话，别的地方使用必须重新定义，typedef定义的好处是在一个地方定义了，背的地方都可以使用


@interface DKRequest : NSObject


@property(nonatomic, assign) BOOL isCache;

// 通常做网络请求的封装，封装外部需要传URL进来，而请求内部需要告诉外部请求是否成功

// 接收外部需要访问的URL
@property(nonatomic, strong) NSString  *urlStr;
// 请求成功回调的Block
@property(nonatomic,copy) successRequset successRequset;
// 请求失败回调的Block
@property(nonatomic,copy) failRequset failRequset;
// 请求开始的方法
- (void)start;



@end
