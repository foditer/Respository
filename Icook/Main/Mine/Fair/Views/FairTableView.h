//
//  FairTableView.h
//  Icook
//
//  Created by MAC39 on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FairTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSMutableArray *sectOneArr;
@property (nonatomic, copy) NSMutableArray *sectTwoArr;
@property (nonatomic, copy) NSMutableArray *sectFouArr;
@property (nonatomic, copy) NSMutableArray *sectFivArr;
@end
