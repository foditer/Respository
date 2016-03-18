//
//  WriteViewController.m
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "WriteViewController.h"

@interface WriteViewController ()
{
    UITextField *_text;
}
@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"简介";
    
}

- (void)createTextFiled
{
    _text = [[UITextField alloc] initWithFrame:CGRectMake(0, 49, kScreenWidth, kScreenHeight)];
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
