//
//  HomeLayoutFrame.h
//  Icook
//
//  Created by Macx on 16/2/9.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

@interface HomeLayoutFrame : NSObject

@property (nonatomic, strong)HomeModel *model;

@property (nonatomic, assign)CGRect homeFrame;
@end
