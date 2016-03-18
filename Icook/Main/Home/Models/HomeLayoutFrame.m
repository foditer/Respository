//
//  HomeLayoutFrame.m
//  Icook
//
//  Created by Macx on 16/2/9.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "HomeLayoutFrame.h"

@implementation HomeLayoutFrame


- (void)setModel:(HomeModel *)model
{
    if (_model != model) {
        _model = model;
        
        [self layoutFrame];
    }
}


- (void)layoutFrame
{
    
    _homeFrame = CGRectMake(0, 0, 200, 255);
    
    if (_model.template == 1 || _model.template == 5) {
        
        float height = 250 + [self layoutFrame:_model.contents.desc font:14 width:kScreenWidth - 10];
        height += [self layoutFrame:_model.contents.title font:12 width:kScreenWidth - 10];
        
        
        _homeFrame = CGRectMake(0, 0, 200, height + 30);
    }
    
}


- (float)layoutFrame:(NSString *)str font:(float)font width:(float)width
{
    NSDictionary *attributeDic = @{
                NSFontAttributeName: [UIFont systemFontOfSize:font]
                                   };
    
    float height = [str boundingRectWithSize:CGSizeMake(width, 80) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil].size.height;
    
    return height;
}
@end
