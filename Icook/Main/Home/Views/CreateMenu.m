//
//  CreateMenu.m
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "CreateMenu.h"
#import "MateralModel.h"
#import "MeansTableViewCell.h"
#import "CreateMenuViewController.h"
#import "WriteViewController.h"

@implementation CreateMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static NSString *kCellID = @"Meansidentifier";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 40;
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        [self registerNib:[UINib nibWithNibName:@"MeansTableViewCell" bundle:nil] forCellReuseIdentifier:kCellID];
        
        _meansSum = 5;
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            {
                if (_materialArr.count < 1) {
                    return 2;
                } else {
                    return _materialArr.count;
                }
            };
            break;
        case 2:
            {
                if (_materialArr.count < 1) {
                    return _meansSum;
                } else {
                    return _materialArr.count;
                }
            };
            break;
        case 3:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        switch (indexPath.row) {
            case 0:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth, 40)];
                
                label.text = _name;
                label.font = [UIFont systemFontOfSize:20];
            
                [cell.contentView addSubview:label];
                
                return cell;
            }
                break;
                
            default:{
                //刚开始简介内容为空
                if (_synopsis  == nil) {
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
                    img.image = [UIImage imageNamed:@"addMark"];
                
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 100, 20)];
                    
                    label.font = [UIFont systemFontOfSize:12];
                    label.textColor = [UIColor grayColor];
                    label.text = @"添加简介";
                    
                    [cell.contentView addSubview:img];
                    [cell.contentView addSubview:label];
                    
                    return cell;
                } else {
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 40)];
                    
                    label.text = _synopsis;
                    
                    [cell.contentView addSubview:label];
                    
                    return cell;
                }
            }
                break;
        }
    }
    if (indexPath.section == 1) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        switch (indexPath.row) {
            case 0:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
                
                label.text = @"用料";
                label.font = [UIFont systemFontOfSize:14];
                
                [cell.contentView addSubview:label];
                
                return cell;
                
            }
                break;
                
            default:{
                if (_materialArr.count < 1) {
                
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
                    img.image = [UIImage imageNamed:@"addMark"];
                
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 100, 20)];
                    
                    label.font = [UIFont systemFontOfSize:12];
                    label.textColor = [UIColor grayColor];
                    label.text = @"添加用料";
                
                    [cell.contentView addSubview:img];
                    [cell.contentView addSubview:label];
                } else {
                    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, kScreenWidth / 2 - 5, 30)];
                    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 10, kScreenWidth / 2 - 10, 30)];
                    MateralModel *model = _materialArr[indexPath.row - 1];
                    
                    name.text = model.name;
                    number.text = model.number;
                    
                    [cell.contentView addSubview:name];
                    [cell.contentView addSubview:number];
                    
                }
                    return cell;
            }
                break;
        }
    }
    
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] init];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
                
                label.font = [UIFont systemFontOfSize:16];
                label.text = @"做法";
                
                [cell.contentView addSubview:label];
                
                return cell;
            }
                break;
                
            default:
            {
                if ((indexPath.row % 2)  == 0 ) {
                    UITableViewCell *cell = [[UITableViewCell alloc] init];
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
                    img.image = [UIImage imageNamed:@"addMark"];
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 100, 20)];
                    
                    label.font = [UIFont systemFontOfSize:12];
                    label.textColor = [UIColor grayColor];
                    label.text = [NSString stringWithFormat:@"添加步骤%li",indexPath.row / 2];
                    
                    [cell.contentView addSubview:img];
                    [cell.contentView addSubview:label];
                    
                    return cell;
                }
                
                MeansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
                
                cell.number.text = [NSString stringWithFormat:@"%li",(indexPath.row + 1) / 2];
                
               [cell.img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
                
                return cell;
            }
                break;
        }
    }
    if(indexPath.section == 3)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        NSArray *arr = @[@"添加步骤",@"调整步骤"];
        for (int i = 0; i < 2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setTitle:arr[i] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:180 / 255.0 alpha:1];
            
            button.frame = CGRectMake(i * (kScreenWidth - 20) / 2  + 10, 10, kScreenWidth / 2 - 20, 30);
            
            [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = 180 + i;
            
            [cell.contentView addSubview:button];
        }
        return cell;
    }
    if (indexPath.section == 4) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"保存" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(10, 10, kScreenWidth - 20, 30);
        
        [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = 182;
        
        [cell.contentView addSubview:button];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 40;
        }
            break;
        case 1:
        {
            return 40;
        }
            break;
        case 2:
        {
            if (indexPath.row % 2 == 0) {
                return 40;
            }
            return 140;
        }
            break;
        default:
            return 40;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        WriteViewController *write = [[WriteViewController alloc] init];
        
        [[self responder] presentViewController:write animated:YES completion:NULL];
        
    }
    
}

//根据字体内容计算高度
- (float)layoutFrame:(NSString *)str font:(float)font width:(float)width
{
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName: [UIFont systemFontOfSize:font]
                                   };
    
    float height = [str boundingRectWithSize:CGSizeMake(width, 80) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil].size.height;
    
    return height;
}



- (void)click:(UITapGestureRecognizer *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        
        if (!isCamera) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你的摄像头不可用" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:NULL]];
            
            [[self responder] presentViewController:alert animated:YES completion:NULL];
            
            return;
        }
        
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        pick.delegate = self;
        
        pick.allowsEditing = YES;
        
        [[self responder] presentViewController:pick animated:YES completion:NULL];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        
        pickVC.delegate = self;
        
        pickVC.allowsEditing = YES;
        
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        
        
        [[self responder] presentViewController:pickVC animated:YES completion:NULL];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[self responder] presentViewController:alert animated:YES completion:NULL];
    
}
//用响应者链来获得父类
- (CreateMenuViewController *)responder
{
    for (UIView* next = [self superview]; next ;next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[CreateMenuViewController class]]) {
            return (CreateMenuViewController*)nextResponder;
        }
    }
    
    return nil;
}

- (void)touch:(UIButton *)sender
{
    if (sender.tag == 180) {
        _meansSum += 2;
        
        [self reloadData];
    }
}

@end
