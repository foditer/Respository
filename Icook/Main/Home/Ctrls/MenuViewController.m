//
//  MenuViewController.m
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "MenuViewController.h"
#import "DataManager.h"
#import "Menu.h"
#import "CreateMenuViewController.h"

@interface MenuViewController ()
{
    UITextField *text;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.title = @"创建菜谱";
    
    text = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, kScreenWidth - 40, 40)];
    text.backgroundColor = [UIColor whiteColor];
    
    text.placeholder = @"例如：清炒小白菜（简约版)";
    
    [self.view addSubview:text];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 230, kScreenWidth - 200, 30)];
    
    label.text = @"创建菜谱的人是厨房里的天使";
    
    label.textColor = [UIColor grayColor];
    
    label.font = [UIFont systemFontOfSize:12];

    [self.view addSubview:label];
    
    [self createButton];
}

- (void)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 20, 20);
    
    [button setImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(0, 0, 60, 40);
    
    [rightButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    rightButton.tag = 150;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = item2;
}

- (void)clickButton:(UIButton *)sender
{
    if (sender.tag == 150) {
        
        if ([text.text isEqualToString:@""]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"菜谱名称不能为空" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
        
          _context = [DataManager shareManager].context;
        
        Menu *menu = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:_context];
        
        menu.name = text.text;
        
        CreateMenuViewController *create = [[CreateMenuViewController alloc] init];
        
        create.name = text.text;
        
        [self.navigationController pushViewController:create animated:YES];
        
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
