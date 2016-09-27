//
//  DKFileDownLoad.h
//  网络数据请求
//
//  Created by lidengke on 15-10-11.
//  Copyright (c) 2015年 lidengke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void(^successRequest)(NSString *fielPath);
typedef void(^failRequest)(NSError *error);

/*
 typedef void (^successRequset)(NSData *data);
 
 typedef void (^failRequset)(NSError *error);
 */

@protocol DKFileDownLoadDelegate <NSObject>

@optional

/**
 * 文件下载开始
 */
- (void)fileDownloadstarted;

/**
 * 文件名
 */
- (void)fileName:(NSString *)fileName;

/**
 * 文件的总大小(长度)
 */
- (void)fileTotalLength:(NSInteger)totalLength;

/**
 * 文件的当前大小(长度)
 */
- (void)fileCurrentLength:(NSInteger)currenLength;

/**
 * 文件的全路径
 */
- (void)fileFullPath:(NSString *)filePath;

/**
 * 文件下载完成
 */
- (void)fileDownloadFinished;

@end

@interface DKFileDownLoad : NSObject

@property(nonatomic, assign) successRequest successRequest;
@property(nonatomic, assign) failRequest failRequest;

@property(nonatomic, assign) id<DKFileDownLoadDelegate> delegate;

/**
 * 下载文件的当前大小(长度)
 */
@property(nonatomic, assign) NSInteger currentLength;

/**
 * 类方法
 * 参数：1.代理 2.文件的网络URL 3.需要存放的文件夹名，在沙盒路径Documents下
 */
//+ (void)downLoadWithDelegate:(id)delegate andWithUrl:(NSString *)url andWithDirectory:(NSString *)directoryName;

/**
 * 对象方法，需要自己设置代理
 */
- (void)downLoadWithUrl:(NSString *)url andWithDirectory:(NSString *)directoryName;


+ (void)downLoadWithDelegate:(id)delegate andWithUrl:(NSString *)url andWithDirectory:(NSString *)directoryName success:(successRequest)successBlock fail:(failRequest)failBlock;



@end






