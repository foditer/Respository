//
//  HomeTableViewCell.m
//  Icook
//
//  Created by Macx on 16/2/1.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHomeModel:(HomeModel *)homeModel
{
    if (homeModel != _homeModel) {
        _homeModel = homeModel;
        [self loadTabelview];
        
    }
}


- (void)loadTabelview
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_homeModel.contents.image[@"url"]]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            img.image = image;
        });
        
    });
    [self.contentView addSubview:img];
    
    if (_homeModel.template == 2) {
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        
        view.backgroundColor = [UIColor blackColor];
        
        view.alpha = 0.3;
        
        [img addSubview:view];
        
        float y = img.center.y;
        UILabel *titleFrist = [[UILabel alloc] init];
        
        titleFrist.numberOfLines = 0;
        
        titleFrist.text = _homeModel.contents.title_1st;
        
        titleFrist.textColor = [UIColor whiteColor];
        
        titleFrist.font = [UIFont systemFontOfSize:18];
        
        titleFrist.frame = CGRectMake(kScreenWidth/ 2 - 100, y - 10, 200, [self layoutFrame:_homeModel.contents.title_1st font:18 width:200]);
        
        UILabel *titleSecond = [[UILabel alloc] init];
        
        titleSecond.numberOfLines = 0;
        
        titleSecond.text = _homeModel.contents.title_2nd;
        
        
        titleSecond.textColor = [UIColor whiteColor];
        
        titleSecond.font = [UIFont systemFontOfSize:14];
        
        titleSecond.frame = CGRectMake(kScreenWidth/ 2 - 60, y + titleFrist.frame.size.height, 120, [self layoutFrame:_homeModel.contents.title_2nd font:14 width:120]);
        
        [self.contentView addSubview:titleFrist];
        [self.contentView addSubview:titleSecond];
    }
    else if(_homeModel.template == 1 || _homeModel.template == 5)
    {
        UILabel *desc = [[UILabel alloc] init];
        
        desc.text = _homeModel.contents.desc;
        
        desc.font = [UIFont systemFontOfSize:14];
        
        desc.frame = CGRectMake(5, 250, kScreenWidth - 10, [self layoutFrame:_homeModel.contents.desc font:14 width:kScreenWidth - 10]);
        
        desc.numberOfLines = 0;
        
        [self.contentView addSubview:desc];
        
        UILabel *title = [[UILabel alloc] init];
        
        title.text = _homeModel.contents.title;
        
        title.font = [UIFont systemFontOfSize:12];
        
        title.numberOfLines = 0;
        
        title.frame = CGRectMake(5, 250 + 5 + [self layoutFrame:_homeModel.contents.desc font:14 width:kScreenWidth - 10], kScreenWidth - 10, [self layoutFrame:_homeModel.contents.title font:12 width:kScreenWidth - 10]);
        
        [self.contentView addSubview:title];
        
        if (_homeModel.template == 5) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(kScreenWidth - 40, 230, 40, 40);
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_homeModel.contents.author.photo]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [button setBackgroundImage:image forState:UIControlStateNormal];
                });
            });
            
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:20];
            
            [self.contentView addSubview:button];
        }
    }
    
}


//根据字体内容计算高度
- (float)layoutFrame:(NSString *)str font:(float)font width:(float)width
{
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName: [UIFont systemFontOfSize:font]
                                   };
    
    float height = [str boundingRectWithSize:CGSizeMake(width, 80) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil].size.height;
    
    return height;
}
@end
