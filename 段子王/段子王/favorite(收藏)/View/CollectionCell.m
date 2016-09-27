//
//  CollectionCell.m
//  Mytravel
//
//  Created by 吴定如 on 15/12/3.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "CollectionCell.h"


@implementation CollectionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    //标题
    UILabel *spotName = [[UILabel alloc] initWithFrame:CGRectMake(20,5, SCREEN_W-40 , 20)];
    spotName.textAlignment = NSTextAlignmentCenter;
    spotName.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:spotName];
    _spotName = spotName;
    //图片
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(spotName.frame)+5, SCREEN_W-80, 180)];
    image.layer.cornerRadius = 5;
    image.clipsToBounds = YES;
    _image = image;
    [self.contentView addSubview:image];
    
   
    UIImageView *play = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    play.image = [UIImage imageNamed:@"大播放图标"];
    play.center = image.center;
    [self.contentView addSubview:play];
    
    
}

-(void)setCellWithDataBaseArray:(NSDictionary *)dataDic
{
    _spotName.text = dataDic[@"text"];
    [_image sd_setImageWithURL:[NSURL URLWithString:dataDic[@"video_cover"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
