//
//  DKRequestManger.m
//  网络请求
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "DKRequestManger.h"

@implementation DKRequestManger


// 不用缓存
+ (void)requsetWithUrl:(NSString *)urlStr success:(successRequset)success fail:(failRequset)fail
{
    
    DKRequest *dk = [[DKRequest alloc] init];
    
    dk.urlStr = urlStr;
    
    dk.successRequset = success;
    
    dk.failRequset = fail;
    
    [dk start];
    
}

// 是否用缓存
+ (void)requsetWithCache:(BOOL)isCache WithUrl:(NSString *)urlStr success:(successRequset)success fail:(failRequset)fail
{
    
    DKRequest *dk = [[DKRequest alloc] init];
    
    dk.urlStr = urlStr;
    
    dk.successRequset = success;
    
    dk.failRequset = fail;
    
    dk.isCache = isCache;
    
    [dk start];
    
}



@end
