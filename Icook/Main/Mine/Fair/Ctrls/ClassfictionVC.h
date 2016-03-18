//
//  ClassfictionVC.h
//  Icook
//
//  Created by MAC39 on 16/2/18.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "BaseViewController.h"

@interface ClassfictionVC : BaseViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *url;
- (instancetype)initWithURL:(NSString *)url;
@end
