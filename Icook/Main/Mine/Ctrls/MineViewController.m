//
//  MineViewController.m
//  Icook
//
//  Created by martin on 2/19/16.
//  Copyright © 2016 zly. All rights reserved.
//

#import "MineViewController.h"
#import "SettingTableViewController.h"
#import "AddFriendsViewController.h"

@interface MineViewController ()
{
    
    __weak IBOutlet UIImageView *_userHeadImage;
    __weak IBOutlet UILabel *_userNickName;
    __weak IBOutlet UILabel *_followLabel;

    __weak IBOutlet UILabel *_fanLabel;

    __weak IBOutlet UILabel *_inroLabel;


    __weak IBOutlet UILabel *_userLocationLabel;


    __weak IBOutlet UISegmentedControl *_myCollection;
    
    __weak IBOutlet UIButton *_favBtn;

    __weak IBOutlet UIButton *_orderBtn;

    __weak IBOutlet UIButton *_discountBtn;

    __weak IBOutlet UIButton *_creditBtn;






}
@end

@implementation MineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createTabBarButton];
    [self _setFuncBtns];
    //设置圆形头像，cornerRafius只需设置成方形imageView的一半即可
    _userHeadImage.layer.cornerRadius = _userHeadImage.frame.size.width / 2;
    _userHeadImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _userHeadImage.layer.masksToBounds = YES;
    
    
}
- (void)_setFuncBtns{
    [_favBtn setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [_orderBtn setImage:[UIImage imageNamed:@"order"] forState:UIControlStateNormal];
    
    [_discountBtn setImage:[UIImage imageNamed:@"discount"] forState:UIControlStateNormal];
    [_creditBtn setImage:[UIImage imageNamed:@"credit"] forState:UIControlStateNormal];

    
    
    
}
- (void)_createTabBarButton{
    //左侧添加好友按钮的创建
    UIButton *addFriendsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addFriendsBtn.size = CGSizeMake(20, 20);
    [addFriendsBtn setImage:[UIImage imageNamed:@"navFindFriendsImage"] forState:UIControlStateNormal];
    [addFriendsBtn addTarget:self action:@selector(leftItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:addFriendsBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右侧设置按钮的创建
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.size = CGSizeMake(20, 20);
    [settingBtn setImage:[UIImage imageNamed:@"rightPageSetting"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(rightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc ]initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
- (void)leftItemClicked : (UIBarButtonItem *)left{
    AddFriendsViewController *addFriendsViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"addF"];
    
    [self.navigationController pushViewController:addFriendsViewCtrl animated:YES];
    
    
    
}
- (void)rightItemClicked : (UIBarButtonItem * )right{
    SettingTableViewController *settingViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"setting"];
    [self.navigationController pushViewController:settingViewCtrl animated:YES];
    
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
