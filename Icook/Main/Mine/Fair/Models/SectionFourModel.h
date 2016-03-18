//
//  SectionFourModel.h
//  Icook
//
//  Created by MAC39 on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "JSONModel.h"

@interface SectionFourModel : JSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *promo_text;
@property (nonatomic, copy) NSString *picurl;
@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *shop_url;
@end
