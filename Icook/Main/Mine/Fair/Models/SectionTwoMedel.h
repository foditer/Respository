//
//  SectionTwoMedel.h
//  Icook
//
//  Created by MAC39 on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//
#import "JSONModel.h"

@interface SectionTwoMedel : JSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *item_type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) float freight;
@property (nonatomic, copy) NSString *picurl;
@property (nonatomic, assign) NSInteger total_sales_volume;
@property (nonatomic, assign) NSInteger type;
@end
