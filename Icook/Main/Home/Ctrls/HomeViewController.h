//
//  HomeViewController.h
//  Icook
//
//  Created by Macx on 16/1/31.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UISearchBarDelegate>

@property(nonatomic, strong)UISearchBar *mySearchBar;

@end
