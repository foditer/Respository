//
//  SectionTwoCV.m
//  Icook
//
//  Created by MAC39 on 16/2/24.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "SectionTwoCV.h"
#import "SectionTwoMedel.h"
#import "ClassfictionVC.h"

@implementation SectionTwoCV

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        _dataArr = [NSMutableArray array];

        self.delegate = self;
        self.dataSource = self;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"SectionTwoCVCell"];
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
    
    [self reloadData];
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

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"SectionTwoCVCell" forIndexPath:indexPath];
    
    SectionTwoMedel *model = _dataArr[indexPath.row];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.size.width, cell.size.width)];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.picurl]]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [imgv setImage:img];
        });
    });
    
    [cell.contentView addSubview:imgv];
    
    UILabel *lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, cell.size.width + 5, cell.size.width - 10, 30)];
    
    lableTitle.text = model.name;
    
    lableTitle.numberOfLines = 2;
    
    lableTitle.font = [UIFont systemFontOfSize:11];
    
    [cell.contentView addSubview:lableTitle];
    
    UILabel *lableSales = [[UILabel alloc] initWithFrame:CGRectMake(5, cell.size.width + 40,cell.size.width - 10, 10)];
    
    lableSales.text = [NSString stringWithFormat:@"已售 %ld", model.total_sales_volume];
    
    lableSales.font = [UIFont systemFontOfSize:9];
    
    lableSales.textColor = [UIColor grayColor];
    
    [cell.contentView addSubview:lableSales];
    
    if (model.freight == 0) {
        UILabel *lableFreight = [[UILabel alloc] initWithFrame:CGRectMake(cell.size.width - 5, cell.size.width + 40, cell.size.width, 10)];
        
        lableFreight.text = @"包邮";
        
        lableFreight.textColor = [UIColor grayColor];
        
        lableFreight.textAlignment = NSTextAlignmentRight;
        
        lableFreight.font = [UIFont systemFontOfSize:9];
        
        [cell.contentView addSubview:lableFreight];
    }
    
    UILabel *lablePrice = [[UILabel alloc] initWithFrame:CGRectMake(5, cell.size.width + 55, 100, 15)];
    
    lablePrice.text = [NSString stringWithFormat:@"￥  %.2f", model.price];
    
    lablePrice.textColor = [UIColor redColor];
    
    lablePrice.font = [UIFont systemFontOfSize:12];
    
    [cell.contentView addSubview:lablePrice];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(176, 260);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url = [NSString stringWithFormat:@"http://www.xiachufang.com/page%@img_txt_detail/", ((SectionTwoMedel *)_dataArr[indexPath.row]).url];
    
    [[self getViewController].navigationController pushViewController:[[ClassfictionVC alloc] initWithURL:url] animated:YES];
}
@end
