//
//  FairTableView.m
//  Icook
//
//  Created by MAC39 on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "FairTableView.h"
#import "ClassfictionVC.h"
#import "SectionTwoCV.h"
#import "SectionOneModel.h"
#import "SectionTwoMedel.h"
#import "SectionThreeModel.h"
#import "SectionFourModel.h"
#import "SectionFiveModel.h"

@implementation FairTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        _sectOneArr = [NSMutableArray array];
        _sectTwoArr = [NSMutableArray array];
        _sectFouArr = [NSMutableArray array];
        _sectFivArr = [NSMutableArray array];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setSectFouArr:(NSMutableArray *)sectFouArr{
    if (_sectFouArr != sectFouArr) {
        _sectFouArr = sectFouArr;
    }
    
    [self reloadData];
}

- (void)setSectOneArr:(NSMutableArray *)sectOneArr{
    if (_sectOneArr != sectOneArr) {
        _sectOneArr = sectOneArr;
    }
    [self reloadData];
}

- (void)setSectFivArr:(NSMutableArray *)sectFivArr{
    if (_sectFivArr != sectFivArr) {
        _sectFivArr = sectFivArr;
    }
    [self reloadData];
}

- (void)setSectTwoArr:(NSMutableArray *)sectTwoArr{
    if (_sectTwoArr != sectTwoArr) {
        _sectTwoArr = sectTwoArr;
    }
    [self reloadData];
}

- (void)_creatMaskView:(UIView *)view
{
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    
    maskView.backgroundColor = [UIColor blackColor];
    
    maskView.alpha = .3;
    
    maskView.userInteractionEnabled = NO;
    
    [view addSubview:maskView];
}

- (UIView *)_createSectionOneView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 10)];
    
    lable.font = [UIFont systemFontOfSize:12];
    
    lable.text = @"好店推荐";
    
    [view addSubview:lable];
    
    int width = (kScreenWidth - 48)/ 3;
    
    for (int i = 0; i < 3; i++) {
        if (_sectFouArr.count > 1) {
            SectionFourModel *model = _sectFouArr[i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(12 + i * (12 + width), 30, width, 155);
            
            button.tag = 221 + i;
            
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:button];
            
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 90)];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.picurl]]];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [imgV setImage:img];
                });
            });
            
            [button addSubview:imgV];
            
            UILabel *lableName = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, width, 12)];
            
            lableName.text = model.name;
            
            lableName.font = [UIFont systemFontOfSize:10];
            
            [button addSubview:lableName];
            
            UILabel *lablePrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 117, width, 12)];
            
            lablePrice.text = [NSString stringWithFormat:@"￥  %.2f",model.price];
            
            lablePrice.font = [UIFont systemFontOfSize:10];
            
            lablePrice.textColor = [UIColor redColor];
            
            [button addSubview:lablePrice];
            
            UILabel *lableSub = [[UILabel alloc] initWithFrame:CGRectMake(0, 134, width, 12)];
            
            lableSub.text = model.promo_text;
            
            lableSub.textColor = [UIColor grayColor];
            
            lableSub.font = [UIFont systemFontOfSize:9];
            
            [button addSubview:lableSub];
        }
    }
    return view;
}

- (UIView *)_createSectionTwoView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 10)];
    
    lable.font = [UIFont systemFontOfSize:12];
    
    lable.text = @"热门主题";
    
    [view addSubview:lable];
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(12, 30, kScreenWidth, 100)];
    
    int width = (kScreenWidth - 48) / 3;
    
    scrollV.contentSize = CGSizeMake(width * 4 + 60, 100);
    
    scrollV.bounces = NO;
    
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    if (_sectOneArr.count > 0) {
        for (int i = 0 ; i  < 4; i++) {
            SectionOneModel *model = _sectOneArr[i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(i * (12 + width), 0, width, 100);
            
            button.tag = 231 + i;
            
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.image]]];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [button setImage:img forState:UIControlStateNormal];
                });
            });
            
            UILabel *lableName = [[UILabel alloc] initWithFrame:CGRectMake((button.frame.size.width - 90) / 2, 46, 90, 10)];
            
            lableName.text = model.title;
            
            lableName.textAlignment = NSTextAlignmentCenter;
            
            lableName.font = [UIFont systemFontOfSize:12];
            
            lableName.textColor = [UIColor whiteColor];
            
            [self _creatMaskView:button];
            
            [button addSubview:lableName];
            
            [scrollV addSubview:button];
        }
        
        [view addSubview:scrollV];
        
        return view;
    }
    return nil;
}

- (UIView *)_createSectionThreeView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    
    if (_sectFivArr.count >0) {
        for (int i = 0; i < 2; i++) {
            SectionFiveModel *model = _sectFivArr[i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(12, 5 + i * 145, kScreenWidth - 24, 135);
            
            button.tag = 241 + i;
            
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.image]]];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [button setImage:img forState:UIControlStateNormal];
                });
            });
            
            UILabel *lableName = [[UILabel alloc] initWithFrame:CGRectMake((button.size.width - 300) / 2, 45, 300, 20)];
            
            lableName.text = model.title;
            
            lableName.font = [UIFont systemFontOfSize:20];
            
            lableName.textAlignment = NSTextAlignmentCenter;
            
            lableName.textColor = [UIColor whiteColor];
            
            UILabel *lableSub = [[UILabel alloc] initWithFrame:CGRectMake((button.size.width - 300) / 2, 65, 300, 20)];
            
            lableSub.font = [UIFont systemFontOfSize:15];
            
            lableSub.text = model.subtitle;
            
            lableSub.textAlignment = NSTextAlignmentCenter;
            
            lableSub.textColor = [UIColor whiteColor];
            
            [self _creatMaskView:button];
            
            [button addSubview:lableName];

            [button addSubview:lableSub];
            
            [view addSubview:button];
        }
    }
    return view;
}

- (void)clickButton:(UIButton *)sender{
    if (sender.tag > 220 && sender.tag <230) {
        [[self getViewController].navigationController pushViewController:[[ClassfictionVC alloc] initWithURL:((SectionFourModel *)_sectFouArr[sender.tag - 221]).shop_url] animated:YES];
    }
    
    if (sender.tag > 230 && sender.tag <240) {
        [[self getViewController].navigationController pushViewController:[[ClassfictionVC alloc] initWithURL:((SectionOneModel *)_sectOneArr[sender.tag - 231]).url] animated:YES];        
    }
    
    if (sender.tag > 240 && sender.tag <250) {
        [[self getViewController].navigationController pushViewController:[[ClassfictionVC alloc] initWithURL:((SectionFiveModel *)_sectFivArr[sender.tag - 241]).url] animated:YES];
    }
}

- (UIViewController *)getViewController
{
    for (UIView * next = [self superview]; next ;next = next.superview) {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - Table View Delegeate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }
    
    if (indexPath.section == 1) {
        return 140;
    }
    if (indexPath.section == 2) {
        return 300;
    }
    return 30 + (1 + _sectTwoArr.count / 2) * 260;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {   UITableViewCell *cell = [[UITableViewCell alloc] init];
            
            UIView *view = [self _createSectionOneView];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [cell.contentView addSubview:view];
            
            return cell;
        }
            break;
        case 1:
        {   UITableViewCell *cell = [[UITableViewCell alloc] init];
            
            UIView *view = [self _createSectionTwoView];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [cell.contentView addSubview:view];
            
            return cell;
        }
            break;
            
        case 2:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            
            UIView *view = [self _createSectionThreeView];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [cell.contentView addSubview:view];
            
            return cell;
        }
            break;
            
            default:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            
            SectionTwoCV *collectionView;
            
            if (_sectTwoArr.count > 0) {
                UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
                
                collectionView = [[SectionTwoCV alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, (1 + _sectTwoArr.count / 2) * 260) collectionViewLayout:layout];
                
                collectionView.dataArr = _sectTwoArr;
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 10)];
            
            lable.font = [UIFont systemFontOfSize:12];
            
            lable.text = @"已上架";
            
            [cell.contentView addSubview:lable];
            
            [cell.contentView addSubview:collectionView];
            
            return cell;
        }
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section < tableView.numberOfSections - 2) {
        return 20;
    }
    return 0;
}

@end
