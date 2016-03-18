//
//  RootTabBarController.m
//  Icook
//
//  Created by Macx on 16/1/31.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    [self createViewCtrls];
    
    [self customTabBar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self removeUITabBarButton];
}
//从storyboard中加载每个controller
-(void)createViewCtrls
{
    NSArray *storyboardNames = @[@"Home", @"Fair", @"Community", @"Mine"];
    NSMutableArray *viewCtrls = [NSMutableArray arrayWithCapacity:storyboardNames.count];
    for (int i = 0; i < storyboardNames.count; i++) {
        NSString *stbdName = storyboardNames[i];
        UIStoryboard *stbd = [UIStoryboard storyboardWithName:stbdName bundle:nil];
        UIViewController *viewCtrl = [stbd instantiateInitialViewController];
        [viewCtrls addObject:viewCtrl];
    }
    
    self.viewControllers = viewCtrls;
}

//去掉tabbar上面本身的button
-(void)removeUITabBarButton
{
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}

- (void)customTabBar
{
    
    float width = kScreenWidth / 11;
    
    
    NSArray *imgArr = @[
                        @"tabADeselected.png",
                        @"tabBDeselected.png",
                        @"tabCDeselected.png",
                        @"tabDDeselected.png"
                        ];
    
    NSArray *selectedImg = @[
                            @"tabASelected.png",
                            @"tabBSelected.png",
                            @"tabCSelected.png",
                            @"tabDSelected.png"
                             ];
    
    NSArray *imgName = @[@"下厨房",@"市集",@"社区",@"我"];
    
    for (int i = 0; i < imgArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(width * 0.5 + 3 * i * width, 5, width , 30);
        
        [button setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:selectedImg[i]] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.5 + 3 * i *width, 39, width, 5)];
        
        label.text = imgName[i];
        
        label.font = [UIFont systemFontOfSize:9];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = [UIColor grayColor];
        
        if (i == 0) {
            button.selected = YES;
            label.textColor = [UIColor orangeColor];
        }
        label.tag = 1004 + i;
        
        [self.tabBar addSubview:button];
        
        [self.tabBar addSubview:label];
    }
}

-(void)selectTab:(UIButton *)sender
{
    self.selectedIndex = sender.tag - 1000;
    
    for (int i = 1000; i < 1004; i++) {
        if (((UIButton *)[self.view viewWithTag:i]).selected == YES) {
            ((UIButton *)[self.view viewWithTag:i]).selected = NO;
            ((UILabel *)[self.view viewWithTag:i + 4]).textColor = [UIColor grayColor];
            
        }
    }
    
    ((UILabel *)[self.view viewWithTag:sender.tag + 4]).textColor = [UIColor orangeColor];
    
    sender.selected = YES;
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
