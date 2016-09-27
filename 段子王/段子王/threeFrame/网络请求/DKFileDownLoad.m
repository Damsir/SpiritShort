//
//  DKFileDownLoad.m
//  网络数据请求
//
//  Created by lidengke on 15-10-11.
//  Copyright (c) 2015年 lidengke. All rights reserved.
//

#import "DKFileDownLoad.h"

@interface DKFileDownLoad ()<NSURLConnectionDataDelegate>
{
    
    NSMutableData *netData;
    NSString *fileDirectoryName;
    NSFileHandle *fileWrite;
}
@end

@implementation DKFileDownLoad

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        netData = [NSMutableData data];
        self.currentLength = 0.0;
    }
    return self;
}

+ (void)downLoadWithDelegate:(id)delegate andWithUrl:(NSString *)url andWithDirectory:(NSString *)directoryName success:(successRequest)successBlock fail:(failRequest)failBlock
{
    DKFileDownLoad *manager = [[DKFileDownLoad alloc] init];
    manager.delegate = delegate;
    [manager downLoadWithUrl:url andWithDirectory:directoryName];
}


- (void)downLoadWithUrl:(NSString *)url andWithDirectory:(NSString *)directoryName
{
    fileDirectoryName = directoryName;
    NSURL *fileUrl = [NSURL URLWithString:url];
    
    NSURLRequest *fileReuqest = [[NSURLRequest alloc] initWithURL:fileUrl];
    
    [NSURLConnection connectionWithRequest:fileReuqest delegate:self];
    
}

#pragma mark ---- NSURLConnectionDataDelegate代理

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [netData setLength:0];
    NSLog(@"网络请求错误呀");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadstarted)])
    {
        [self.delegate fileDownloadstarted];
    }
    /**
     * 代理回调文件的总长度
     */
    if (self.delegate && [self.delegate respondsToSelector:@selector(fileTotalLength:)]) {
        
        [self.delegate fileTotalLength:response.expectedContentLength];
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@/",fileDirectoryName]];
    [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *filePath = [path stringByAppendingString:response.suggestedFilename];
    [manager createFileAtPath:filePath contents:nil attributes:nil];
    
    /**
     * 代理回调文件的文件名
     */
    if (self.delegate && [self.delegate respondsToSelector:@selector(fileName:)]) {
        [self.delegate fileName:response.suggestedFilename];
    }
    /**
     * 代理回调文件的路径
     */
    if (self.delegate && [self.delegate respondsToSelector:@selector(fileFullPath:)]){
        [self.delegate fileFullPath:filePath];
    }
    
    // 创建文件句柄
    fileWrite = [NSFileHandle fileHandleForWritingAtPath:filePath];

}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.currentLength += data.length;
    /**
     * 代理回调当前文件的大小
     */
    if (self.delegate && [self.delegate respondsToSelector:@selector(fileCurrentLength:)]) {
        
        [self.delegate fileCurrentLength:self.currentLength];
    }
    

    // 移到文件尾部，写文件
    [fileWrite seekToEndOfFile];
    [fileWrite writeData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [fileWrite closeFile];
    fileWrite = nil;
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadFinished)]) {
        [self.delegate fileDownloadFinished];
    }
    
    
}
@end





