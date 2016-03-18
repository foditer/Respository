//
//  HomeModel.h
//  Icook
//
//  Created by Macx on 16/2/9.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "JSONModel.h"
#import "ContentsModel.h"

@interface HomeModel : JSONModel

@property (nonatomic, copy)NSString *url;
@property (nonatomic, assign)int template;
@property (nonatomic, copy)ContentsModel *contents;

@end
