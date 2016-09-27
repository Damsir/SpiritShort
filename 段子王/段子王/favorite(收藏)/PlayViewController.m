//
//  PlayViewController.m
//  段子王
//
//  Created by Dam on 15/12/19.
//  Copyright © 2015年 李登科. All rights reserved.
//

#import "PlayViewController.h"
//播放视频的头文件
#import <MediaPlayer/MediaPlayer.h>

@interface PlayViewController ()
{
    MPMoviePlayerViewController *player;
}
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createMoviePlayer];
}
-(void)createMoviePlayer{
    
    player=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:self.playUrl]];

    player.view.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    player.view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
    [player.view setTransform:transform];
    [self.view addSubview:player.view];
    
    // 视频播放完的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //显示导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}


// 视频播放完成取消通知
- (void)MovieFinished:(NSNotification *)notice{
    
    MPMoviePlayerController *player0 = [notice object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [player0 stop];
    [player0.view removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
