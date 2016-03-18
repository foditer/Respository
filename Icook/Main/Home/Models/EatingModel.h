//
//  EatingModel.h
//  Icook
//
//  Created by Macx on 16/2/5.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "JSONModel.h"

@interface EatingModel : JSONModel

@property(nonatomic ,assign)NSInteger n_dishes;
@property(nonatomic ,copy)NSString *name;
@property(nonatomic ,strong)NSDictionary *dishes;

@end
