//
//  MineViewController.m
//  TravelFun
//
//  Created by 吴定如 on 15/11/26.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "MineViewController.h"
#import "SuggestionViewController.h"//建议
#import "MyCollectViewController.h"//收藏

static CGFloat ImageOriginHight = 200.0f;
static CGFloat TempHeight = 15.0f;

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIAlertViewDelegate>
{
    UIImageView *header;
    UITableView *MineTable;
    UIButton *icon;//用户头像
    UIImagePickerController *imagePicker;
    UIImage *image;//选择的头像
    long long size;//缓存大小
    NSString *path;//缓存路径
   
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的";
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMineView];
    
    
}
-(void)createMineView
{
    MineTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    MineTable.contentInset = UIEdgeInsetsMake(ImageOriginHight, 0, 0, 0);
    MineTable.tableFooterView = [[UIView alloc] init];
    MineTable.delegate=self;
    MineTable.dataSource=self;
    [self.view addSubview:MineTable];
    [UIColor redColor];
    header = [[UIImageView alloc] initWithFrame:CGRectMake(0, -ImageOriginHight-TempHeight, SCREEN_W, ImageOriginHight+TempHeight)];
    header.userInteractionEnabled = YES;
    header.image = [UIImage imageNamed:@"my"];
    [MineTable addSubview:header];
    
    icon = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    icon.center = CGPointMake(SCREEN_W/2.0, header.frame.size.height + 80);
    icon.layer.cornerRadius = icon.bounds.size.width/2.0;
    icon.clipsToBounds = YES;
    [icon setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [icon addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:icon];
    
}
#pragma mark -- 更换头像
-(void)changeIcon
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
    sheet.delegate = self;
    [sheet showInView:self.view];
}

#pragma mark -- sheet代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if (buttonIndex == 1)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        return;
    }
    
    [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
}
//图片库方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = info[@"UIImagePickerControllerOriginalImage"];
    [icon setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
   
}


#pragma mark -- table代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titles = @[@"我的收藏",@"建议反馈",@"清除缓存"];
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark -- hearder放大效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat Offset_y  = scrollView.contentOffset.y;
    CGFloat Offset_x = (Offset_y + ImageOriginHight)/1.5;
    
    if ( ABS(Offset_y) > ImageOriginHight)
    {
        CGRect frame = MineTable.frame;
        frame.origin.y = Offset_y - TempHeight;
        frame.size.height =  -Offset_y + TempHeight;
        frame.origin.x = Offset_x;
        frame.size.width = SCREEN_W +  ABS(Offset_x)*2;
        header.frame = frame;
        
        icon.bounds = CGRectMake(0, 0, 60-Offset_x/4.0, 60-Offset_x/4.0);
        icon.center = CGPointMake((SCREEN_W+ ABS(Offset_x)*2)/2.0,(-Offset_y + TempHeight) /2.0+80);
        icon.layer.cornerRadius = (60-Offset_x/4.0)/2.0;
        
    }
}

#pragma mark -- Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0)
    {
        MyCollectViewController *collectVC = [[MyCollectViewController alloc] init];
        collectVC.title = @"我的收藏";
        [self presentViewController:collectVC animated:YES completion:nil];
    }
    else if (indexPath.row == 1)
    {
        SuggestionViewController *suggestVC = [[SuggestionViewController alloc] init];
        suggestVC.title = @"意见反馈";
        [self presentViewController:suggestVC animated:YES completion:nil];
    }
    
    //清理缓存
    else
    {
        dispatch_async(
          dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                , ^{
                    NSString *CachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    NSLog(@"CachesPath路径:%@", CachesPath);
                    
                    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:CachesPath];
                    NSLog(@"files个数:%ld",[files count]);
                    for (NSString *p in files) {
                        
                        path = [CachesPath stringByAppendingPathComponent:p];
                        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                            NSError *error;
                            size = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
                            NSLog(@"==%lf",size/1024.0/1024.0);
                            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                        }
                    }
                [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    }
}
-(void)clearCacheSuccess
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"共有缓存: %.2lfMB",size/1024.0/1024.0] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
  
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
          NSLog(@"清理成功");
    }
    else
    {
        return;
    }
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
