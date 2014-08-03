//
//  ZDNavViewController.m
//  新浪微博
//
//  Created by Dong on 14-7-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDNavViewController.h"

@interface ZDNavViewController ()

@end

@implementation ZDNavViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 只有在ios7以上时才用清空代理
    if (iOS7) {          // 手势 识别器
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
@end
