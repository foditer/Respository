//
//  SelectedViewController.h
//  Icook
//
//  Created by Macx on 16/2/2.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "BaseViewController.h"
#import "SelectButtonModel.h"
@interface SelectedViewController : BaseViewController
{
    UIWebView *_webView;
}
@property (nonatomic, strong)SelectButtonModel *selecModel;

@end
