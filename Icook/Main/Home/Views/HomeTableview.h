//
//  HomeTableview.h
//  Icook
//
//  Created by Macx on 16/2/1.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeTableview : UITableView<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong)NSMutableArray *buttonArr;//首页四个button的内容

@property (nonatomic, copy)NSString *popPicurl;//流行菜谱

@property (nonatomic, strong)NSMutableArray *eatingArr;//早饭午饭晚饭的内容

@property (nonatomic, copy)NSMutableArray *showArr;//下面的tableview的内容

@property (nonatomic, copy)NSMutableArray *titleArr;//起始标题

@end
