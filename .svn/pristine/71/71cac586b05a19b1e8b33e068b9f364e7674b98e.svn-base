//
//  ZDLoginViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-28.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDLoginViewController.h"
//#import "ZDWeiBoViewController.h"
//#import "ZDQQLoginViewController.h"
#import "ZDRootViewController.h"
#import "ZDAccountTool.h"
#import "ZDAccount.h"
#import "MBProgressHUD+NJ.h"
#import "ZDHttpTool.h"

@interface ZDLoginViewController () <UIWebViewDelegate>
@property (nonatomic,assign) BOOL settingEdge;
@end

@implementation ZDLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7 && !self.settingEdge) {
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _settingEdge = YES;
    }
    ZDCommonArrowItem *weibo = [ZDCommonArrowItem itemWithTitle:@"新浪微博登陆" icon:@"logon_weibo_icon"];
    weibo.opertion = ^(){
        [self weiboLogin];
    };
//    weibo.destVC = [ZDWeiBoViewController class];
    ZDCommonArrowItem *QQ = [ZDCommonArrowItem itemWithTitle:@"腾讯QQ登陆" icon:@"logon_qq_icon"];
    QQ.opertion = ^(){
         [self QQLogin];
    };
//    QQ.destVC = [ZDQQLoginViewController class];
    ZDCommonGroup *group = [self addGroup];
    group.items = @[weibo,QQ];
    [self initTencent];
}

- (void)weiboLogin
{
    self.view = [[UIWebView alloc]init];
    // 获取当前webView
    UIWebView *webView = (UIWebView *)self.view;
    // 获取固定格式的URL地址 传入客户ID和回调地址
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",ZDAppKey,ZDAppRedirectUrl];
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    // 设置webView的代理
    webView.delegate = self;
    // 通过url实例化一个URL请求
    NSURLRequest *relRequest = [[NSURLRequest alloc]initWithURL:url];
    // 让webView加载URL请求
    [webView loadRequest:relRequest];
}
/**
 *  当webView开始加载时 调用第三方框架 提示用户正在加载中...
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}
/**
 *  当webView完成加载时 隐藏提示框
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
/**
 *  加载失败时
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

/**
 *  每次发送请求都会调用次方法
 *
 *  @param request  URL请求
 *
 *  @return 返回YES允许此次请求,返回NO不允许此次请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.判断请求的request中是否包含code= ,如果保护code=就将code取出, 利用code去获取access token  如果不包含 ==0  表示此次请求不成功 有问题
    // 1.通过请求的URL获取 请求的绝对字符串
    NSString *url = request.URL.absoluteString;
    NSLog(@"%@", url);
    // 2.检测URL字符串中是否包含 "code="
    // 包含表示请求认证通过,可以利用code去获取access_token
    NSRange range = [url rangeOfString:@"code="];
    // 判断是包含code=
    if (range.length != 0) {
        // 包含则截取出code=  之后的所有字符串
        NSString *code = [url substringFromIndex:NSMaxRange(range)];
        // 通过code字符串向服务器从新发送一个POST请求 获取授权信息
        [self accessTokenWithCode:code];
    }
    return YES;
}
/**
 *  根据已经授权的标记code  换取访问标记
 *
 *  @param code 已经授权的标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"client_id"] = ZDAppKey;
    parmas[@"client_secret"] = ZDAppSecret;
    parmas[@"grant_type"] = @"authorization_code";
    parmas[@"code"] = code;
    parmas[@"redirect_uri"] = ZDAppRedirectUrl;
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    // .keyValues第三方框架 模型转字典
    [ZDHttpTool postWithUrl:url params:parmas success:^(id json) {
        // 1.将服务器返回的信息转换为模型
        ZDAccount *account = [ZDAccount accountWithDict:json];
        
        // 2.归档数据
        [ZDAccountTool saveAccount:account];
        
        ZDRootViewController *root = [[ZDRootViewController alloc]init];
        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *windows = app.keyWindow;
        windows.rootViewController = root;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)dealloc{
    NSLog(@"销毁登陆界面");
}







- (void)QQLogin
{
    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_t", nil];
    [_tencentOAuth authorize:permissions inSafari:NO];
}

- (void)initTencent
{
    NSString *appid = @"222222";
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:appid andDelegate:self];
}

- (void)tencentDidLogin
{
    /** 获取用户信息 */
    if ([_tencentOAuth getUserInfo]) {
        ZDLog(@"获取用户信息成功");
    }else{
        ZDLog(@"获取用户信息失败");
    }
}

/** 获取用户信息 */
- (void)getUserInfoResponse:(APIResponse *)response
{
    [self saveAccount:response.jsonResponse];
    ZDRootViewController *root = [[ZDRootViewController alloc]init];
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *windows = app.keyWindow;
    windows.rootViewController = root;
}

- (void)saveAccount:(NSDictionary *)respones
{
    NSDictionary *dict = respones;
    ZDAccount *account = [[ZDAccount alloc]init];
    account.nickname = dict[@"nickname"];
    account.city = dict[@"city"];
    account.figureurl_qq_1 = dict[@"figureurl_qq_1"];
    account.figureurl_qq_2 = dict[@"figureurl_qq_2"];
    account.gender = dict[@"gender"];
    [ZDAccountTool saveAccount:account];
}


- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
    
}
@end
