//
//  FairViewController.m
//  Icook
//
//  Created by Macx on 16/2/3.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "FairViewController.h"
#import "ClassfictionVC.h"
#import "SearchViewController.h"
#import "ShopingCartTVC.h"
#import "FairTableView.h"
#import "SectionOneModel.h"
#import "SectionTwoMedel.h"
#import "SectionThreeModel.h"
#import "SectionFourModel.h"
#import "SectionFiveModel.h"

@interface FairViewController ()
{
    __weak IBOutlet FairTableView *FairTV;
}
@end

@implementation FairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createNavigationBarButton];
    
    [self _loadData];
//    [self _createWebView];
    
    // Do any additional setup after loading the view.
}

- (void)_createNavigationBarButton
{
    //左侧分类按钮的创建
    UIButton *classftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    classftButton.frame = CGRectMake(0, 0, 20, 20);
    [classftButton setImage:[UIImage imageNamed:@"leftPageButtonBackgroundNormal"] forState:UIControlStateNormal];
    [classftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    classftButton.tag = 201;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:classftButton];
    
    //右侧购物车按钮的创建
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0, 0, 20, 20);
    [cartButton setImage:[UIImage imageNamed:@"shoppingCart"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    cartButton.tag = 202;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    self.navigationItem.rightBarButtonItem = item1;
    //中间搜索按钮的穿件
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchButton.frame = CGRectMake(0, 0, kScreenWidth - 90, 25);
    
    searchButton.backgroundColor = [UIColor colorWithRed:195/225.0 green:201/225.0 blue:205/225.0 alpha:1];
    
    [searchButton setTitle:@"搜索商品" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:188/255.0 green:196/255.0 blue:194/255.0 alpha:1] forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [searchButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 90)/2 - 50, 5, 15, 15)];
    
    img.image = [UIImage imageNamed:@"searchIcon"];
    
    [searchButton addSubview:img];
    
    searchButton.tag = 203;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    NSArray *barArr = [NSArray arrayWithObjects:item, item2, nil];
    
    self.navigationItem.leftBarButtonItems = barArr;
}

- (void)_loadData{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSString *url = @"http://www.xiachufang.com/page/ec-tab/ajax/outlets/";
    
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *moArr = [NSMutableArray array];
        
        NSDictionary *dic = responseObject;
        
        NSDictionary *dic1 = dic[@"fresh_outlet"];
        
        if (dic1.count != 0) {
            SectionOneModel *modelFir = [[SectionOneModel alloc] initWithDictionary:dic1 error:nil];
            
            [moArr addObject:modelFir];
        }
    
        NSArray *arr = dic[@"hot_outlets"];
        
        for (NSDictionary *dic2 in arr) {
            SectionOneModel *model = [[SectionOneModel alloc] initWithDictionary:dic2 error:nil];
            
            [moArr addObject:model];
        }
        FairTV.sectOneArr = moArr;
        
        NSMutableArray *moOutArr = [NSMutableArray array];
        
        NSArray *arrOut = dic[@"outlets"];
        
        for (NSDictionary *dic3 in arrOut) {
            SectionFiveModel *model = [[SectionFiveModel alloc] initWithDictionary:dic3 error:nil];
            
            [moOutArr addObject:model];
        }
        
        FairTV.sectFivArr = moOutArr;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    url = @"http://www.xiachufang.com/page/ec-tab/ajax/shelf-items/?limit=22&offset=0";
    
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *moArr = [NSMutableArray array];

        NSArray *arr = responseObject;
        
        for (NSDictionary *dic in arr) {

            if ([dic[@"item_type"] isEqualToString:@"goods"]) {
                SectionTwoMedel *model = [[SectionTwoMedel alloc] initWithDictionary:dic error:nil];
                
                [moArr addObject:model];
            }
            
//            if ([dic[@"item_type"] isEqualToString:@"card"]) {
//                NSArray *arrCard = dic[@"parts"];
//                
//                for (NSDictionary *dicCard in arrCard) {
//                    SectionThreeModel *model = [[SectionThreeModel alloc] initWithDictionary:dicCard error:nil];
//                  
//                    [moArr addObject:model];
//                }
//            }
            
            FairTV.sectTwoArr = moArr;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error2");
    }];
    
    url = @"http://www.xiachufang.com/page/ec-tab/ajax/promo-goods/";
    
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *moArr = [NSMutableArray array];
        
        NSDictionary *dic = responseObject;
        
        NSArray *arr = dic[@"content"];
        
        for (NSDictionary *dic1 in arr) {
            SectionFourModel *model = [[SectionFourModel alloc] initWithDictionary:dic1 error:nil];

            [moArr addObject:model];
        }
        
        FairTV.sectFouArr = moArr;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)_createWebView
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    self.webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://www.xiachufang.com/page/ec-tab/?version=12"];
    
    
    
    NSString *retStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@",retStr);
    
    [_webView loadHTMLString:retStr baseURL:url];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
//    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *js_result2 = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById<div class=\"main-block\">.innerHTML; "];
    
    NSLog(@"%@",js_result2);
}

- (void)clickButton:(UIButton *)sender
{
    if (sender.tag == 201) {
        [self.navigationController pushViewController:[[ClassfictionVC alloc] initWithURL:@"http://www.xiachufang.com/page/goods-category/"] animated:YES];
    }
    
    if (sender.tag == 202) {
        [self.navigationController pushViewController:[[ShopingCartTVC alloc] init] animated:YES];
    }
    
    if (sender.tag == 203) {
        
        [self.navigationController pushViewController:[[ClassfictionVC alloc] initWithURL:@"http://www.xiachufang.com/page/goods-search/?keyword="]   animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
