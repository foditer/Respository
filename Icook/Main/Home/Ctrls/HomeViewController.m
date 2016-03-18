//
//  HomeViewController.m
//  Icook
//
//  Created by Macx on 16/1/31.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "HomeTableview.h"
#import "SelectButtonModel.h"
#import "SelectedViewController.h"
#import "EatingModel.h"
#import "HomeModel.h"
#import "MenuViewController.h"

@interface HomeViewController ()
{
    UIBarButtonItem *_item;
    UIButton *searchButton;
    __weak IBOutlet HomeTableview *_tableview;
}
@end

@implementation HomeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"button" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTabbarButton];
    [self creatsearchButton];
    
    [self loadButtonData];
    [self loadHomeData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(click:) name:@"button" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTabbarButton
{
    //左侧的+号按钮的创建
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addButton.frame = CGRectMake(0, 0, 20, 20);
    [addButton setImage:[UIImage imageNamed:@"homepageCreateRecipeButton"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = 101;
    
    _item = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    self.navigationItem.leftBarButtonItem = _item;
   //创建菜篮子按钮
    UIButton *bagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bagButton.frame = CGRectMake(0, 0, 20, 20);
    [bagButton setImage:[UIImage imageNamed:@"buylistButtonImage"] forState:UIControlStateNormal];
    [bagButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    bagButton.tag = 102;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:bagButton];
    
    self.navigationItem.rightBarButtonItem = item1;
}
//创建搜索按钮navagitionbar正中间
- (void)creatsearchButton
{
    
    _mySearchBar = [[UISearchBar alloc] initWithFrame:self.navigationItem.titleView.bounds];
    
    _mySearchBar.layer.cornerRadius = 5;
    _mySearchBar.layer.borderWidth = 0;
    
    _mySearchBar.layer.masksToBounds = YES;
    _mySearchBar.delegate = self;
    _mySearchBar.searchBarStyle = UISearchBarStyleMinimal;
    _mySearchBar.placeholder = @"菜谱、食谱";
    self.navigationItem.titleView = _mySearchBar;

}

- (void)click:(NSNotification *)sender
{
    NSInteger tag = [sender.userInfo[@"senderTag"] integerValue];
    
    if (tag >= 110 && tag <= 113 ) {
        
        SelectedViewController *selecVC = [[SelectedViewController alloc] init];
        selecVC.selecModel = _tableview.buttonArr[tag - 110];
        
        [self.navigationController pushViewController:selecVC animated:YES];
    }
    else {
        SelectedViewController *selecVC = [[SelectedViewController alloc] init];
    
        
        selecVC.selecModel.url = sender.userInfo[@"url"];
        
        NSLog(@"%@",selecVC.selecModel.url);
        
        [self.navigationController pushViewController:selecVC animated:YES];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (searchButton != nil) {
        [self.navigationController.navigationBar addSubview:searchButton];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (searchButton != nil) {
        [searchButton removeFromSuperview];
    }
}

- (void)loadButtonData
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSString *url = @"http://api.xiachufang.com/v2/init_page_v5.json?version=5.2.1&timezone=Asia%2FShanghai&api_sign=cd48ea59860e14c4239fa2d1309bdb6e&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=gpAFQ-drRBqxxYngnBLBJg";
    
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        
        NSArray *arr = (dic[@"content"])[@"navs"];
        
        NSMutableArray *muArr = [NSMutableArray array];
        
        for (NSDictionary *dics in arr) {
            SelectButtonModel *model = [[SelectButtonModel alloc] initWithDictionary:dics error:nil];
            
            [muArr addObject:model];
        }
        _tableview.buttonArr = muArr;
        
        _tableview.popPicurl = (dic[@"content"])[@"pop_recipe_picurl"];
        
        NSMutableArray *eatArr = ((dic[@"content"])[@"pop_events"])[@"events"];
        
        NSMutableArray *eatArray = [NSMutableArray array];
        
        for (NSDictionary *eatDic in eatArr) {
            EatingModel *model = [[EatingModel alloc] initWithDictionary:eatDic error:nil];
            [eatArray addObject:model];
        }
        
        _tableview.eatingArr = eatArray;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}

- (void)loadHomeData
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSString *url = @"http://api.xiachufang.com/v2/issues/list.json?cursor=&origin=iphone&api_sign=82a455e301ba4f03b2b9544ee23fd216&sk=gpAFQ-drRBqxxYngnBLBJg&size=2&timezone=Asia%2FShanghai&version=5.2.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
    
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *titleArr = [NSMutableArray array];
    
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
    
        NSArray *issues = (dic[@"content"])[@"issues"];
        
        for (int i = 0; i < issues.count; i++) {
            
            NSArray *items = (issues[i])[@"items"];
            
            [titleArr addObject:(issues[i])[@"title"]];
            
            NSMutableArray *dataArr = [NSMutableArray array];
            
            for (NSDictionary *itemDic in items) {
                
                HomeModel *model = [[HomeModel alloc] initWithDictionary:itemDic error:nil];
                NSLog(@"%@",model);
                [dataArr addObject:model];
            }
            
            [arr addObject:dataArr];
            
            
        }
        
        _tableview.titleArr = titleArr;
        _tableview.showArr = arr;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"申请失败");
        
    }];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//     [self.navigationController pushViewController:[[SearchViewController alloc] init]   animated:YES];
    
    return YES;
}

- (void)clickButton:(UIButton *)sender
{
    if (sender.tag == 101) {
        [self.navigationController pushViewController:[[MenuViewController alloc] init] animated:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
