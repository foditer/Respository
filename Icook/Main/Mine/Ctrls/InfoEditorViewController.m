//
//  InfoEditorViewController.m
//  Icook
//
//  Created by martin on 2/22/16.
//  Copyright © 2016 zly. All rights reserved.
//

#import "InfoEditorViewController.h"

@interface InfoEditorViewController ()

@end

@implementation InfoEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createNavButton];
    self.title = @"编辑个人信息";


}
- (void)_createNavButton{

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo :)];
    rightItem.tintColor = [UIColor magentaColor];
    self.navigationItem.rightBarButtonItem = rightItem ;
    
    
}
-(void)saveInfo : (UIBarButtonItem * )save{
    
    
    
    
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
