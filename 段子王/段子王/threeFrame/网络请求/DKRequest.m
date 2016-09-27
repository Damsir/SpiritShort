//
//  DKRequest.m
//  网络请求
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "DKRequest.h"

@interface DKRequest ()<NSURLConnectionDataDelegate>
{
    // 用于存放请求回来的网络数据(二进制流)
    NSMutableData *netData;
}
@end

@implementation DKRequest


- (void)start
{
    // 是否使用缓存
    if (self.isCache)
    {
        // 先去寻找是否有缓存，如果有就去取，没有在请求
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        
        NSInteger hashIndex = [self.urlStr hash];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%ld",path,hashIndex];
        
        // 文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        if ([mgr fileExistsAtPath:filePath])
        {
            // 如果存在，取出数据，返回，不做网络请求
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            
            self.successRequset(data);
            
            return;
        }
    }

    // 创建网络请求
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    netData = [NSMutableData data];
    
    [connection start];
    
    
    
}

#pragma mark NSURLConnectionDataDelegate协议方法

// 请求错误时候回调
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [netData setLength:0];
    if (self.failRequset) // 外部如果没有赋值直接调用会崩溃
    {
        self.failRequset(error);
    }
}

// 第一次得到服务器回应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 每次开始前，清空上次的数据
    [netData setLength:0];
}
// 每一次请求的数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 拼接网络请求回来的数据
    [netData appendData:data];
    
}
// 网络请求结束
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   
    // 是否缓存
    if (self.isCache)
    {
        // 存储网络数据，沙盒目录下面，用于下次直接读取本地数据，不用多次网络请求
        
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        
        // 通过hash计算出URL的hash值，用来做文件璀错缓存，下次还是用这个路径取
        
        // hash：是一种通用的hash算法，同样的二进制生成的二进制值都是相等的，通常用来表示文件是否被修改了，我们这用来作为文件的唯一标示
        
        NSInteger hashIndex = [self.urlStr hash];
        
        
        // 存储文件的路径，把网路请求的数据存储到沙盒目录下面
        NSString *filePath = [NSString stringWithFormat:@"%@/%ld",path,hashIndex];
        
        [netData writeToFile:filePath atomically:YES];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // 判断Block是否存在，调用Block，把请求数据传出去
    if (self.successRequset)
    {
        self.successRequset(netData);
    }
    
    
}



@end

















