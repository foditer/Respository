//
//  ClassfictionVC.m
//  Icook
//
//  Created by MAC39 on 16/2/18.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "ClassfictionVC.h"
#import "ShopingCartTVC.h"

@interface ClassfictionVC ()

@end

@implementation ClassfictionVC

- (instancetype)initWithURL:(NSString *)url
{
    if (self = [super init]) {
        _url = url;
    
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        _webView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationBarButton];
 
    NSURL *url = [NSURL URLWithString:_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}


- (void)createNavigationBarButton{
    //自定义返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 211;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = item;
    
    //右侧购物车按钮的创建
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cartButton.frame = CGRectMake(0, 0, 20, 20);
    [cartButton setImage:[UIImage imageNamed:@"shoppingCart"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    cartButton.tag = 212;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    self.navigationItem.rightBarButtonItem = item1;
}

- (void)clickButton:(UIButton *)sender
{
    if (sender.tag == 211) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if (sender.tag == 212) {
        [self.navigationController pushViewController:[[ShopingCartTVC alloc] init] animated:YES];
    }
}

#pragma mark - webView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *theTitle=[_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    NSLog(@"%@",theTitle);
    
    [self.navigationItem setTitle:theTitle];
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
