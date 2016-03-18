//
//  SelectedViewController.m
//  Icook
//
//  Created by Macx on 16/2/2.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "SelectedViewController.h"

@interface SelectedViewController ()

@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 20, 20);
    
    [button setImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = item;
    
    self.title = _selecModel.name;
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    NSURL *url = [NSURL URLWithString:_selecModel.url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
}

- (instancetype)init
{
    if (self = [super init]) {
        _selecModel = [[SelectButtonModel alloc] init];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clickButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
