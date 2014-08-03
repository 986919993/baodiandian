//
//  ZDAboutViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDAboutViewController.h"
#import "ZDAboutHeaderView.h"
@interface ZDAboutViewController ()
@property (nonatomic,assign) BOOL settingEdge;
@end

@implementation ZDAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (iOS7 && !self.settingEdge) {
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _settingEdge = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectZero;
    [self.view addSubview:webView];
    self.title = @"关于我们";
    // 1.具体数据
    ZDCommonItem *mark = [ZDCommonArrowItem itemWithTitle:@"评分支持"];
    
    mark.opertion = ^{
        NSString *appid = @"725296055";
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
    };
    
    ZDCommonItem *call = [ZDCommonArrowItem itemWithTitle:@"客户电话"];
    call.subtitle = @"010-82935150/60/70";
    call.opertion = ^{
        NSURL *url = [NSURL URLWithString:@"tel://01082935150"];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    };
    
    ZDCommonGroup *group = [self addGroup];
    group.items = @[mark, call]; 
    // 2.header
    self.tableView.tableHeaderView = [ZDAboutHeaderView aboutHeaderView];
}

@end
