//
//  SectionTwoCV.h
//  Icook
//
//  Created by MAC39 on 16/2/24.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionTwoCV : UICollectionView<UICollectionViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSMutableArray *dataArr;
@end
