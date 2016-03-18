//
//  CreateMenu.h
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateMenu : UITableView<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)NSMutableArray *materialArr;

@property (nonatomic, strong)NSMutableArray *meansArr;

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *synopsis;

@property (nonatomic, assign)int meansSum;
@end
