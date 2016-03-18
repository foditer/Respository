//
//  UIView+ViewController.m
//  03-响应者链
//
//  Created by kangkathy on 15/12/21.
//  Copyright © 2015年 kangkathy. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController {
    
    UIResponder *responder = self.nextResponder;
    
    do {
        //isKindOfClass：表示当前对象是某个类或者是其子类的实例对象
        //isMemberOfClass:表示当前对象是某个类的实例对象
        if([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
        
        
    } while (responder != nil);
    
    return nil;
    
    
}

@end
