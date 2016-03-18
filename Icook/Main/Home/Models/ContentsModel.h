//
//  ContentsModel.h
//  Icook
//
//  Created by Macx on 16/2/17.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "JSONModel.h"
#import "AuthorModel.h"

@interface ContentsModel : JSONModel

@property (nonatomic, copy)NSString<Optional> *title_2nd;//表示在图上面的标题2
@property (nonatomic, copy)NSString<Optional> *title_1st;//表示在图上面的标题1
@property (nonatomic, copy)NSDictionary *image;//cell的背景图片
@property (nonatomic, copy)NSString<Optional> *desc;//表示在图片下方的文字内容介绍
@property (nonatomic, copy)NSString<Optional> *title;//表示在下面的标题
@property (nonatomic, strong)AuthorModel<Optional> *author; // 作者
@end
