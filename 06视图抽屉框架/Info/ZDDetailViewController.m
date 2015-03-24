//
//  CZArticleViewController.m
//  05-网易新闻
//
//  Created by LNJ on 14-7-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDDetailViewController.h"
#import "ZDHttpTool.h"

@interface ZDDetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ZDDetailViewController

- (void)setDocid:(NSString *)docid
{
    _docid = docid;
    
    self.articleURLStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html", docid];
}

- (void)loadView
{
    self.webView = [[UIWebView alloc] init];
    self.view = self.webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizableImageNamed:@"viewBG"]];
    [self loadData];
}

// 加载网络数据
- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置返回类型的mimeType
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:self.articleURLStr parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *dict) {
        // 根据数据字典内容，创建HTML字符串，创建之后，用WebView加载
        [self htmlTextWithDict:dict[self.docid]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

// 根据数据字典内容，创建HTML字符串，创建之后，用WebView加载
- (void)htmlTextWithDict:(NSDictionary *)dict
{
    // 建立一个可变字符串
    NSMutableString *html = [NSMutableString string];

    // 0. CSS
    [html appendString:@"<style type='text/css'>h1{font-size:18px;} img{width:300px;}</style>"];

    // 1. 标题
    [html appendFormat:@"<h1>%@</h1>", dict[@"title"]];
    
    // 2. 来源和时间
    [html appendFormat:@"<p>%@ %@</p>", dict[@"source"], dict[@"ptime"]];
    
    // 3. 正文
    [html appendFormat:@"%@", [self bodyTextWithDict:dict]];
//    NSLog(@"%@",html);
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)bodyTextWithDict:(NSDictionary *)dict
{
    NSMutableString *body = [dict[@"body"] mutableCopy];
    
    // 正则表达式的步骤
    // 1. 匹配方案
    NSString *pattern = @"<!--(.*?)-->";
    // 2. 正则表达式
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators error:NULL];
    // 3. 匹配
    NSArray *array =  nil;
    if (body != nil) {
        array = [regx matchesInString:body options:0 range:NSMakeRange(0, body.length)];
    }
    
    // 倒着替换
    //
    int count = array.count - 1;
    for (int i = count; i >= 0; i--) {
        NSTextCheckingResult *result = array[i];
        
        NSRange range = [result rangeAtIndex:0];
        
        // 取字符串的字串
        NSString *imageRefStr = [body substringWithRange:range];
        
        // 判断字符串中是否包含有IMG文字
        if ([imageRefStr rangeOfString:@"IMG"].length > 0) {
            NSString *str = [self imageTextWithRefString:imageRefStr inDict:dict];
            
            // 替换body中的文字
            NSString *imgStr = [NSString stringWithFormat:@"<img src='%@'/>", str];
            [body replaceCharactersInRange:range withString:imgStr];
        }
    }
    
    return body;
}

- (NSString *)imageTextWithRefString:(NSString *)ref inDict:(NSDictionary *)dict
{
    // <!--IMG#4-->
    // 1. 从字典中取出img数组
    NSArray *imgs = dict[@"img"];
    
    // 2. 遍历字典
    NSString *result = nil;
    for (NSDictionary *d in imgs) {
        // 判断字典中的ref是否与传入的字符串相同
        if ([d[@"ref"] isEqualToString:ref]) {
            result = d[@"src"];
            break;
        }
    }
    
    return result;
}

@end
