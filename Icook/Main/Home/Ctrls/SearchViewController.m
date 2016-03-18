//
//  SearchViewController.m
//  Icook
//
//  Created by Macx on 16/2/1.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITextFieldDelegate>
{
    UITextField *_text;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
//    [self createTextFiled];
    
    [self creatItemButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatItemButton
{
    UIButton *cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cleanButton.frame = CGRectMake(0, 0, 40, 20);
    [cleanButton setTitle:@"取消" forState:UIControlStateNormal];
    [cleanButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [cleanButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:cleanButton];
    self.navigationItem.rightBarButtonItem = item2;
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)createTextFiled
{
    _text = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 80, 25)];
    _text.backgroundColor = [UIColor colorWithRed:195/225.0 green:201/225.0 blue:205/225.0 alpha:1];
    
    _text.borderStyle = UITextBorderStyleRoundedRect;
    _text.placeholder = @"菜谱、食材";
    _text.font = [UIFont fontWithName:@"Arial" size:12.0f];
    
    [self.navigationController.navigationBar addSubview:_text];
    
   UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 140)/2 - 50, 5, 15, 15)];
    
    img.image = [UIImage imageNamed:@"searchIcon"];
    
    _text.delegate = self;
    
    _text.leftView = img;
    
    _text.leftViewMode = UITextFieldViewModeAlways;
    
    _text.textAlignment = NSTextAlignmentLeft;
    
    [_text addSubview:img];
}


- (void)touchButton:(UIButton *)sender
{
    [_text removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.hidesBackButton = YES;
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
