//
//  HomeViewController.m
//  段子王
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李登科. All rights reserved.
//

#import "HomeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DKHomeModel.h"
#import "CustomHomeCell.h"
#import "CustomCellModel.h"
#import "DKIndicator.h"
#import "DKAppInfoModel.h"
#import "UMSocial.h"


@interface HomeViewController ()<CustomHomeCellDelegate,UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
{
    MPMoviePlayerController *moviePlayer; // 视频播放器
    DKHomeModel *homeModel;               // 数据对象
    DKAppInfoModel *appInfo;              // 数据管理对象
    NSMutableArray *frameArr;             // 计算后的尺寸
    NSTimer *timer;                       // 定时器
    BOOL isFirstCreatePlayer;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatNavView];
    
    //当前视图下只能播放一个
    isFirstCreatePlayer = YES;
    // 初始化
    appInfo = [[DKAppInfoModel alloc] init];
    homeModel = [[DKHomeModel alloc] init];
   
    
    // 加载数据
    [self loadNetData];
    
    [self.table registerClass:[CustomHomeCell class] forCellReuseIdentifier:@"home"];
    self.table.separatorStyle = NO;
    
    // 添加头部、尾部事件
    [self.table addHeaderWithTarget:self action:@selector(refreshData)];
    [self.table addFooterWithTarget:self action:@selector(loadMoreData)];

}

// 创建导航栏Item
- (void)creatNavView
{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_nav"]];
    img.frame = CGRectMake(0, 0, 40, 40);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:img];
    
    
    self.title = @"精段子";
}



// 加载数据
- (void)loadNetData
{
    // 判断是否第一次请求数据
    static BOOL isFirst = YES;
    if (isFirst) {
      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    __weak typeof(*&self)weakSelf = self;
    [appInfo loadDataWithBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess)
        {
            homeModel = appInfo.homeModel;
            [weakSelf upData];
            if (isFirst) {
                if (frameArr.count) {
                    isFirst = NO;
                }
                else
                {
                    [weakSelf loadNetData];
                }
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [weakSelf.table headerEndRefreshing];
            [weakSelf.table reloadData];
        }
        else
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [weakSelf.table headerEndRefreshing];
            [weakSelf.table footerEndRefreshing];
            [weakSelf showNetErrorView];
        }
    }];
}

/** 创建错误提示 */
- (void)showNetErrorView
{
    UILabel *errorLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, SCREEN_W, 30)];
    errorLab.backgroundColor = [UIColor redColor];
    errorLab.text = @"服务器维护，暂无数据";
    errorLab.textAlignment = NSTextAlignmentCenter;
    errorLab.textColor = [UIColor whiteColor];
    [self.navigationController.view insertSubview:errorLab belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
        
        errorLab.transform = CGAffineTransformMakeTranslation(0, errorLab.height);
        
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            errorLab.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [errorLab removeFromSuperview];
        }];
    }];
}


// 更新数据
- (void)upData
{
    frameArr = [NSMutableArray array];
    for (int i=0; i<homeModel.data.count; i++) {
        
        // 网络数据
        DKDataInfo *dataInfo = homeModel.data[i];
        
        // 给Cell赋值
        CustomCellModel *cellModel = [[CustomCellModel alloc] init];
        cellModel.dataInfo = dataInfo;
        
        // 计算尺寸
        CellFrameModel *frameModle = [[CellFrameModel alloc] init];
        frameModle.dataModel = cellModel;
        
        // 添加到数组
        [frameArr addObject:frameModle];
    }
}

#pragma mark ---- 刷新和加载更多
- (void)refreshData
{
    [moviePlayer.view removeFromSuperview];
    moviePlayer = nil;
    isFirstCreatePlayer = YES;
    [self loadNetData];
}

- (void)loadMoreData
{
    __weak typeof(*&self)weakSelf = self;
    [appInfo loadMoreDataBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            homeModel = appInfo.homeModel;
            [self upData];
            [weakSelf.table footerEndRefreshing];
            [weakSelf.table reloadData];
        }
        else
        {
            [weakSelf.table footerEndRefreshing];
            [weakSelf showNetErrorView];
        }
    }];
}

#pragma mark ---- UITableView代理回调
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return frameArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"home"];
    cell.delegate = self;
    cell.section = indexPath.section;
    cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];

    if (frameArr.count > indexPath.section) {
        CustomCellModel *dataModel = [frameArr[indexPath.section] dataModel];
        cell.frameModel = frameArr[indexPath.section];
        [cell setUIWithDataModel:dataModel];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (frameArr.count> indexPath.section) {
        return [frameArr[indexPath.section] cell_height];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

// 滑出屏幕时，销毁播放器
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /** 转换坐标系，从当前坐标系转到以屏幕左上角为原点的坐标系 */
    CGRect newRect = [moviePlayer.view convertRect:moviePlayer.view.bounds toView:self.view];
    
    if (newRect.origin.y<-moviePlayer.view.height/3*2+64 || newRect.origin.y+moviePlayer.view.height>SCREEN_H-49) {
        
        [timer invalidate];
        [moviePlayer.view removeFromSuperview];
        moviePlayer = nil;
       isFirstCreatePlayer = YES;
    }
}


#pragma mark ---- CustomHomeCellDelegate代理
- (void)playVideoWithView:(UIView *)view andWithImage:(UIImage *)img andWithUrl:(NSString *)url
{
//    DKLog(@"%@",url);
    
    
    if (isFirstCreatePlayer)
    {
        // 1.创建一个视频播放器
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
        moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        moviePlayer.controlStyle = MPMovieControlStyleNone;
        
        // 2.设置位置和大小
        moviePlayer.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        [view addSubview:moviePlayer.view];
        
        // 3.准备和开始播放
        [moviePlayer prepareToPlay];
        [moviePlayer play];
        
        // 4.设置播放等待动画和进度条
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:moviePlayer.view.bounds];
        imageView.image = img;
        imageView.tag=1000;
        [moviePlayer.view addSubview:imageView];
        
        // 菊花
        DKIndicator *acti = [[DKIndicator alloc] initWithFrame:CGRectMake(imageView.width/2-20, imageView.height/2-20, 40, 40)];
        [acti startAnimating];
        [imageView addSubview:acti];
        
        // 进度条
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame)-3, CGRectGetWidth(view.frame), 2)];
        progressView.tag = 1003;
        progressView.progressTintColor = MAIN_COLOR;
        [moviePlayer.view addSubview:progressView];
        
        isFirstCreatePlayer = NO;
    }
    
    
    // 5.注册一个监听者，监听加载完成和播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFinish:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
}
// 加载完成调用的方法
- (void)loadFinish:(NSNotification *)noti
{
    UIImageView *imageView = (UIImageView *)[moviePlayer.view viewWithTag:1000];
    [imageView removeFromSuperview];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(currentPlaybackTime:) userInfo:nil repeats:YES];
}
// 视屏播放完成调用的方法
- (void)playFinish:(NSNotification *)noti
{
    MPMoviePlayerController *theMovie = [noti object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    [moviePlayer.view removeFromSuperview];
    [timer invalidate];
    moviePlayer = nil;
    isFirstCreatePlayer = YES;
}
// 监听当前播放进度
- (void)currentPlaybackTime:(NSTimer *)timer
{
    UIProgressView *progressView = (UIProgressView *)[moviePlayer.view viewWithTag:1003];
    if (moviePlayer.currentPlaybackTime) {
        progressView.progress = (CGFloat)moviePlayer.currentPlaybackTime/moviePlayer.duration;
    }
}
- (void)changeSourceData:(NSString *)str inSection:(NSInteger)section
{
    CellFrameModel *frame =  frameArr[section];
    frame.dataModel.dataInfo.group.comment_count = str;
    [self upData];
    [self.table reloadData];
}

#pragma mark ---- 赞
- (void)clickDiggInSection:(NSInteger)section
{
    DKDataInfo *dataInfo = homeModel.data[section];
    dataInfo.group.digg_count = [NSString stringWithFormat:@"%ld",dataInfo.group.digg_count.integerValue+1];
    [self upData];
    [self.table reloadData];
}

#pragma mark ---- 踩
- (void)clickBuryInSection:(NSInteger)section
{
    DKDataInfo *dataInfo = homeModel.data[section];
    dataInfo.group.bury_count = [NSString stringWithFormat:@"%ld",dataInfo.group.bury_count.integerValue+1];
    [self upData];
    [self.table reloadData];
}

#pragma mark ---- 分享
- (void)showShareView
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5614e40267e58ed89300425d" shareText:@"自己的段子" shareImage:nil shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToFacebook,UMShareToEmail,UMShareToDouban,UMShareToWechatFavorite] delegate:self];
}

#pragma mark ---- UMSocialUIDelegate
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess)
    {
        DKLog(@"分享成功");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
   // DKLog(@"内存过大");
    
}

@end












