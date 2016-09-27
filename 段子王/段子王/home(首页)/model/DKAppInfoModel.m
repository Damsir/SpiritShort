//
//  DKAppInfoModel.m
//  段子王
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "DKAppInfoModel.h"
#import "DKDataInfo.h"


@interface DKAppInfoModel ()

@end

@implementation DKAppInfoModel

- (void)loadDataWithBlock:(refreshDataBlock)block
{

    [[AFHTTPRequestOperationManager manager] GET:HOME_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *tempArr = [NSMutableArray array];
        NSMutableArray *oldArr = [NSMutableArray array];
        
        // 1.备份上一次的数据
        if (self.homeModel.data.count) {
            for (int i=0; i<self.homeModel.data.count; i++) {
                DKDataInfo *dataInfo = self.homeModel.data[i];
                [oldArr addObject:dataInfo];
            }
        }
        
        // 2.请求数据
        self.homeModel = [[DKHomeModel alloc] initWithData:operation.responseData error:nil];
        
        // 3.处理数据
        for (int i=0; i<self.homeModel.data.count; i++)
        {
            DKDataInfo *dataInfo = self.homeModel.data[i];
            dataInfo.group.comment_count = @"收藏";
            dataInfo.ad = nil;
            
            if ([dataInfo.group.category_name isEqualToString:@"搞笑视频"]) {
                
                [tempArr addObject:dataInfo];
            }
        }
        
        // 4.判断请求的数据是否可用
        if (!tempArr.count) {
            self.homeModel.data = [oldArr copy];
        }
        else
        {
            // 来到这就是没有可用数据，显示上次的数据
            self.homeModel.data = nil;
            self.homeModel.data = [tempArr copy];
        }
        
        if (block) {
            block(YES,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        if (block) {
            block(NO,error);
        }
    }];
    
    
    
}

- (void)loadMoreDataBlock:(refreshDataBlock)block
{
   
    NSString *str1 = @"http://ic.snssdk.com/neihan/stream/mix/v1/?mpic=1&essence=1&content_type=-101&message_cursor=-1&longitude=114.4356191304&latitude=30.459605484803&bd_longitude=114.429058&bd_latitude=30.453917&bd_city=%E6%AD%A6%E6%B1%89%E5%B8%82&am_longitude=114.428891&am_latitude=30.45379&am_city=%E6%AD%A6%E6%B1%89%E5%B8%82&am_loc_time=1444396765857&count=";
    
    NSString *str2 = @"0&min_time=1444396769&screen_width=720&iid=3104228663&device_id=6482137329&ac=wifi&channel=grey&aid=7&app_name=joke_essay&version_code=440&version_name=4.4.0&device_platform=android&ssmix=a&device_type=MI+2S&os_api=21&os_version=5.0.2&uuid=860955025989421&openudid=2971623e2b864ba3&manifest_version_code=432";
    
    NSString *newUrl = [NSString stringWithFormat:@"%@%d%@",str1,3,str2];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    
    [[AFHTTPRequestOperationManager manager] GET:newUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 1.备份上次现有的数据
        for (int i=0 ; i< self.homeModel.data.count ; i++) {
            DKDataInfo *dataInfo = self.homeModel.data[i];
            
            [tempArr addObject:dataInfo];
        }
        
        // 2.请求数据
        self.homeModel = [[DKHomeModel alloc] initWithData:operation.responseData error:nil];
        
        // 3.处理数据
        for (int i=0 ; i< self.homeModel.data.count ; i++)
        {
            DKDataInfo *dataInfo = self.homeModel.data[i];
            dataInfo.group.comment_count = @"下载";
            dataInfo.ad = nil;
            
            if ([dataInfo.group.category_name isEqualToString:@"搞笑视频"]) {
                [tempArr addObject:dataInfo];
            }
        }
        self.homeModel.data = nil;
        self.homeModel.data = [tempArr copy];
        
        block(YES,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        block(NO,error);
    }];
    
    
}


@end











