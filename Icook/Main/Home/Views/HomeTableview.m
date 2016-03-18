//
//  HomeTableview.m
//  Icook
//
//  Created by Macx on 16/2/1.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "HomeTableview.h"
#import "SelectButtonModel.h"
#import "EatingModel.h"
#import "HomeTableViewCell.h"
#import "HomeLayoutFrame.h"

@implementation HomeTableview
{
    UIScrollView *_scrView;
    UIPageControl *_pageControl;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.dataSource = self;
        _buttonArr = [NSMutableArray array];
        _eatingArr = [NSMutableArray array];
        _showArr = [NSMutableArray array];
        _titleArr = [NSMutableArray array];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
}

- (UIView *)createCell
{
    if (_buttonArr.count > 1) {
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    
    float width = kScreenWidth / 4;
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        SelectButtonModel *model = _buttonArr[i];
        
        button.frame = CGRectMake(0.25 * width + i * width , 10, width / 2, 45);
      //这里涉及了一个网络图片的异步加载
        
        button.tag = 110 + i;
        
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
       dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
           UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.picurl]]];
           dispatch_sync(dispatch_get_main_queue(), ^{
               [button setImage:image forState:UIControlStateNormal];
             
           });
           
       });
        
        [view addSubview:button];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.25 * width + i * width, 57, width / 2, 7)];
        
        label.text = model.name;
        
        label.font = [UIFont systemFontOfSize:9];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:label];
        
    }
    return view;
    }
    else {
        return nil;
    }
}

- (void)setButtonArr:(NSMutableArray *)buttonArr
{
    if (_buttonArr != buttonArr) {
        _buttonArr = buttonArr;
        [self reloadData];
    }
}

- (void)clickButton:(UIButton *)sender
{
    NSNumber *tag = [NSNumber numberWithInteger:sender.tag];
    
    NSDictionary *dic = @{
                      @"senderTag":tag
                          };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"button" object:nil userInfo:dic];
    
}

- (UIScrollView *)createScrollerView
{
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    view.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _eatingArr.count, 80);
    view.contentOffset = CGPointMake(0, 0);
    view.pagingEnabled = YES;
    view.delegate = self;
    view.showsHorizontalScrollIndicator = NO;
    view.showsVerticalScrollIndicator = NO;
    
    view.tag = 500;
    
    NSArray *arr = @[@"一 早餐 一",@"一 午餐 一",@"一 晚餐 一"];
    
    NSArray *eatarr = @[@"themeBigPicForBreakfast",@"themeBigPicForLaunch",@"themeBigPicForSupper"];
    
    
    for (int i = 0;i < _eatingArr.count; i++) {
        
        EatingModel *model = _eatingArr[i];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, 80)];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 3, 80)];
        
        img.contentMode = UIViewContentModeScaleAspectFill;
        
        img.image = [UIImage imageNamed:eatarr[i]];
        
        [button addSubview:img];
        
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 3, 20, kScreenWidth / 3, 10)];
        
        firstLabel.text = arr[i];
        
        [button addSubview:firstLabel];
        
        UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 3 + 18, 37, kScreenWidth / 3 - 36, 8)];
        
        secondLabel.text = [NSString stringWithFormat:@"%li作品",model.n_dishes];
        
        secondLabel.font = [UIFont systemFontOfSize:10];
        
        secondLabel.textColor = [UIColor grayColor];
        
        [button addSubview:secondLabel];
        
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth / 3) * 2, 10, kScreenWidth / 3, 70)];
        rightView.contentMode = UIViewContentModeScaleAspectFit;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:((model.dishes[@"dishes"])[i])[@"thumbnail_280"]]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                rightView.image = image;
               
            });
            
        });
        
        [button addSubview:rightView];
        
        [view addSubview:button];
    }
    
    return view;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat frame = scrollView.contentOffset.x;
    
    int n = frame / kScreenWidth ;
    
    _pageControl.currentPage = n;
}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section <= 2) {
        return 1;
    }
    
    NSArray *arr = _showArr[section - 3];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _showArr.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        { UITableViewCell *cell = [[UITableViewCell alloc] init];
            
            float width = kScreenWidth / 2;
            
            for (int i = 0; i < 2;i++ ) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0 + i * width, 0, width, 130);
                if (i == 0) {
                    
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        
                        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_popPicurl]]];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [button setBackgroundImage:image forState:UIControlStateNormal];
                        });
                    });
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30 , 100, width - 60, 10)];
                    
                    label.text = @"本周流行菜谱";
                    label.textColor = [UIColor whiteColor];
                    label.font = [UIFont systemFontOfSize:15];
                    
                    [cell addSubview:button];
                    [button addSubview:label];
                }else {
                    [button setBackgroundImage:[UIImage imageNamed:@"feedsNoFriends"] forState:UIControlStateNormal];
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, width - 60, 10)];
                    label.text = @"试着添加一些厨友";
                    label.textColor = [UIColor whiteColor];
                    label.font = [UIFont systemFontOfSize:15];
                    
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
                    
                    img.image = [UIImage imageNamed:@"feedsNoFriendsIcon"];
                    
                    img.center = button.center;
                    
                    [cell addSubview:button];
                    [button addSubview:label];
                    [cell addSubview:img];
                }
              
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
        }
            
            break;
        case 1:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] init];
                
                UIView *view = [self createCell];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                [cell.contentView addSubview:view];
                
                return cell;
            };
            break;
        case 2:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] init];
                
               _scrView = [self createScrollerView];
                
                _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 70, 10, 10)];
                
                _pageControl.pageIndicatorTintColor = [UIColor grayColor];
                _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
                
                _pageControl.numberOfPages = _eatingArr.count;
                _pageControl.hidesForSinglePage = YES;
                _pageControl.enabled = NO;
                
                [cell.contentView addSubview:_scrView];
                [cell.contentView addSubview:_pageControl];
                
                return cell;
            };
            break;
        default:{
            HomeTableViewCell *cell = [[HomeTableViewCell alloc] init];
            
            if (indexPath.row == 0) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 70, 20, 140, 20)];
                
                label.text = _titleArr[indexPath.section - 3];
                
                label.font = [UIFont systemFontOfSize:14];
                
                [cell.contentView addSubview:label];
                
                return cell;
            }
            
            cell.homeModel = (_showArr[indexPath.section - 3])[indexPath.row - 1];
            
            return cell;
        }
            break;
    }
    
    return nil;
}

- (void)setShowArr:(NSMutableArray *)showArr
{
    if (showArr != _showArr) {
        _showArr = showArr;
        [self reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 130;
    }
    else if (indexPath.section == 1) {
        return 70;
    }
    else if (indexPath.section == 2) {
        return 80;
    }
    else {
        
        if (indexPath.row == 0) {
            return 40;
        }
        
        HomeLayoutFrame *frame = [[HomeLayoutFrame alloc] init];
        
        frame.model = (_showArr[indexPath.section - 3])[indexPath.row - 1];
        
        return frame.homeFrame.size.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section > 2 && indexPath.row > 0) {
        NSNumber *tag = [NSNumber numberWithInt:115];
        
        HomeModel *model = (_showArr[indexPath.section - 3])[indexPath.row - 1];
        
        NSString *str = model.url;
        
        NSDictionary *dic = @{
                              @"senderTag":tag,
                              @"url": str
                              };
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"button" object:nil userInfo:dic];
        
    }
    
}



@end
