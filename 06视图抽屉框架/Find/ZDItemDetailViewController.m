//
//  ZDItemDetailViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-8-1.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDItemDetailViewController.h"
#import "NSString+Extend.h"

@interface ZDItemDetailViewController ()

@property (nonatomic,strong) UILabel *detail;

@property (nonatomic,strong) UIWebView *webView;
@end

static NSString *TitleCellID = @"TitleCell";
static NSString *ContentCellID = @"ContentCell";
@implementation ZDItemDetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.view = self.webView;
    
    [self htmlTextWithDict:self.dict];
    self.title = @"详细内容";

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.view.window.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

// 根据数据字典内容，创建HTML字符串，创建之后，用WebView加载
- (void)htmlTextWithDict:(NSDictionary *)dict
{
//    NSLog(@"%@",dict);
    // 建立一个可变字符串
    NSMutableString *html = [NSMutableString string];
    
    // 0. CSS
    [html appendString:@"<style type='text/css'>h1{font-size:19px; color:#0000ff} img{width:300px;}</style>"];
    
    // 1. 标题
    [html appendFormat:@"<h1>%@</h1>", dict[@"title"]];
    
    // 2. 来源和时间
    
    [html appendFormat:@"<hr style='filter:alpha(opacity=50,finishopacity=100,style=5);height:1px' color=#CDCDCD>"];
    
    // 3. 正文
    [html appendFormat:@"%@", dict[@"detail"]];
    
    //    NSLog(@"%@",html);
    [self.webView loadHTMLString:html baseURL:nil];
}
@end
