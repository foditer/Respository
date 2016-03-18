//
//  AuthorModel.h
//  Icook
//
//  Created by Macx on 16/2/9.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "JSONModel.h"

@interface AuthorModel : JSONModel

@property (nonatomic, copy)NSString *url; // 点击头像跳转的url连接
@property (nonatomic, copy)NSString *photo;//作者头像
@property (nonatomic, copy)NSString *id;//作者的ID
@property (nonatomic, copy)NSString *name;//作者的名字


@end
