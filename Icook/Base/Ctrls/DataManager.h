//
//  DataManager.h
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
@property(nonatomic, strong)NSManagedObjectContext *context;
+(instancetype)shareManager;

@end
