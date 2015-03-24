//
//  ZDMoreViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDMoreViewController.h"
#import "MBProgressHUD+NJ.h"
#import "ZDMoreHeaderView.h"
#import "ZDAccountTool.h"
#import "ZDAboutViewController.h"
#import "ZDMoreHeaderView.h"
#import "MBProgressHUD+NJ.h"
#import "ZDLoginViewController.h"
#import "ZDUserViewController.h"
#import "ZDAccountTool.h"
#import "ZDAccount.h"
#import "NSDate+NJ.h"
#import "ZDSaoViewController.h"
#import "UIView+NJ.h"
#import "UIImage+NJ.h"

#define kCurrentName @"com.hackemist.SDWebImageCache.default"
#define cachesPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kCurrentName]

static NSString *heardID = @"headerView";
@interface ZDMoreViewController () <UIAlertViewDelegate,ZDMoreHeaderViewDelegate>
{
    ZDMoreHeaderView *_headerView;
}
@property (nonatomic, assign) BOOL settingEdge;

@property (nonatomic, strong) UIImageView *bgIcon;

@property (nonatomic, strong) ZDCommonArrowItem *clearCache;
@property (nonatomic, strong) UIButton *homeButton;

@end

@implementation ZDMoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupItems];
    self.tableView.sectionFooterHeight = 10;
    if (iOS7 && !self.settingEdge) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 90, 0);
        _settingEdge = YES;
    }
    self.tableView.scrollEnabled= YES;
    _bgIcon = [[UIImageView alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear |NSCalendarUnitHour;
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    BOOL isZao = (nowCmps.hour) < 11;
    BOOL isXia = (nowCmps.hour) < 17;
    BOOL isWan = (nowCmps.hour) < 24;
    NSString *imageName = nil;
    NSInteger inter = arc4random_uniform(3);
    if (isZao) {
        imageName = [NSString stringWithFormat:@"zaoshang%d",inter];
    }else if(isXia){
        imageName = [NSString stringWithFormat:@"zhongwu%d",inter];
    }else if (isWan){
        imageName = [NSString stringWithFormat:@"wanshang%d",inter];
    }

    _bgIcon.image = [UIImage imageNamed:imageName];
    _bgIcon.bounds = CGRectMake(0, 0, 320, 300);
    _bgIcon.layer.anchorPoint = CGPointMake(0.5, 0);
    _bgIcon.layer.position = CGPointMake(160, -95);
    [self.tableView insertSubview:_bgIcon atIndex:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftmenu_geren2"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
    [self.navigationItem.leftBarButtonItem setCustomView:self.homeButton];
}
- (UIButton *)homeButton{
    if (!_homeButton) {
        _homeButton = [[UIButton alloc] init];
        _homeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_homeButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_geren2"] forState:UIControlStateNormal];
        [_homeButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_geren1"] forState:UIControlStateHighlighted];
        //        [_postButton setTitle:@"发帖" forState:UIControlStateNormal];
        _homeButton.frame = CGRectMake(0, 0, 36, 36);
        [_homeButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homeButton;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 20) return;
    
    // 1.向上的阻力系数（值越大，阻力越大，向上的力越大）
    CGFloat upFactor = 0.6;
    
    // 2.到什么位置开始放大
    // value越大，越早放大
    CGFloat value = 50;
    CGFloat upMin = - (_bgIcon.frame.size.height / value) / (1 - upFactor);
    
    // 3.还没到特定位置，就网上挪动
    if (offsetY >= upMin) {
        _bgIcon.transform = CGAffineTransformMakeTranslation(0, offsetY * upFactor);
    } else {
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, offsetY - upMin * (1 - upFactor));
        CGFloat s = 1 + (upMin - offsetY) * 0.005;
        _bgIcon.transform = CGAffineTransformScale(transform, s, s);
    }
}


// 通用数据
- (void)setupItems
{
    /** 0组 */
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    // 设置footerView
    [self setupFooter];
    _headerView = [ZDMoreHeaderView moreHeaderView];
    _headerView.headerDelegate = self;
    self.tableView.tableHeaderView = _headerView;
}

/** 点击头部 */
- (void)didClickHeaderView:(BOOL)isAccount
{
//    for (UIViewController *controller in self.childViewControllers) {
//        // 将子视图控制器的视图从父视图中删除
//        [controller.view removeFromSuperview];
//        // 将视图控制器从父视图控制器中删除
//        [controller removeFromParentViewController];
//    }
    ZDAccount *account = [ZDAccountTool account];
 
    if (account.nickname.length!=0) {
        ZDUserViewController *user = [[ZDUserViewController alloc] init];
        user.title = @"用户信息";
        [self.navigationController pushViewController:user animated:YES];
    }else{
        ZDLoginViewController *login = [[ZDLoginViewController alloc]init];
        login.title = @"登陆";
        [self.navigationController pushViewController:login animated:YES];
    }
}

- (void)setupGroup0{
    ZDCommonArrowItem *sao = [ZDCommonArrowItem itemWithTitle:@"扫一扫"];
    sao.icon = @"saoyisao";
//    sao.destVC = [ZDSaoSaoSao class];
    ZDCommonGroup *group = [self addGroup];
    group.items = @[sao];
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[[ZDSaoViewController alloc] init] animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            [self rootOutCaches];
        }else{
            [self checkEditionAndUpdate];
        }
    }else{
        if (indexPath.row == 0){
            [self opinionAndFeedback];
        }else{
            [self aboutUs];
        }
    }
}

// 清楚缓存
- (void)rootOutCaches{
    // 1.提示用户
    [MBProgressHUD showMessage:@"正在清除缓存ing...."];
    // 2.删除缓存文件夹
    // 2.1获取文件管理者对象
    NSFileManager *manager =  [NSFileManager defaultManager];
    BOOL success = [manager removeItemAtPath:cachesPath error:nil];
    // 3.隐藏提示框
    [MBProgressHUD hideHUD];
    if (success) {
        [MBProgressHUD showSuccess:@"删除成功"];
        self.clearCache.subtitle = nil;
        [self.tableView reloadData];
    }else{
        [MBProgressHUD showError:@"没有缓存文件!"];
        self.clearCache.subtitle = nil;
        [self.tableView reloadData];
    }
}

// 检测版本更新
- (void)checkEditionAndUpdate{
    // 1.获得用户当前软件的版本
    
    // 2.把当前版本号发给服务器
    if (NO) { // 有新版本
        // 2.1.弹框显示有新版本，展示版本新特性
        NSString *appid = @"908308962";
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
        // 2.2.点击“马上更新”，跳到appstore（跟评分功能一致）
    } else {
        [MBProgressHUD showSuccess:@"当前为最新版本"];
    }
}

// 意见反馈
- (void)opinionAndFeedback{
    NSString *appid = @"908308962";
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
    NSURL *url = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:url];
}

// 关于我们
- (void)aboutUs{
    [self.navigationController pushViewController:[[ZDAboutViewController alloc] init] animated:YES];
}

- (void)setupFooter
{
    // 1.创建按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // 2.设置标题
    [btn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    // 3.设置背景图片
    [btn setBackgroundImage:[UIImage resizableImageNamed:@"common_card_background"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizableImageNamed:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backAccount) forControlEvents:UIControlEventTouchUpInside];
    // 4.设置frame
    btn.height = 45;
    self.tableView.tableFooterView = btn;
}
- (void)backAccount
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出此账号?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [ZDAccountTool removeAccount];
        for (UIViewController *controller in self.childViewControllers) {
            // 将子视图控制器的视图从父视图中删除
            [controller.view removeFromSuperview];
            // 将视图控制器从父视图控制器中删除
            [controller removeFromParentViewController];
        }
        UIApplication *app = [UIApplication sharedApplication];
        [app.delegate application:app didFinishLaunchingWithOptions:nil];
    }
}

- (void)setupGroup1{
    
//    ZDCommonArrowItem *updata = [ZDCommonArrowItem itemWithTitle:@"检测更新"];
//    NSString *key =  (__bridge NSString *)kCFBundleVersionKey;
//    NSString *versionCode = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
//    updata.subtitle = [NSString stringWithFormat:@"当前版本:%@",versionCode];
  
    
    self.clearCache = [ZDCommonArrowItem itemWithTitle:@"清除图片缓存"];
  
    double fileSize = [self sizeAtPath:cachesPath]/(1024.0);
    self.clearCache.subtitle = [NSString stringWithFormat:@"%.fMB",fileSize];
    
    ZDCommonGroup *group = [self addGroup];
    group.items = @[self.clearCache];
}

- (void)setupGroup2{
    ZDCommonArrowItem *idea = [ZDCommonArrowItem itemWithTitle:@"意见反馈"];

    ZDCommonArrowItem *about = [ZDCommonArrowItem itemWithTitle:@"关于我们"];
    about.destVC = [ZDAboutViewController class];
    ZDCommonGroup *group = [self addGroup];
    group.items = @[idea,about];
}


/** 计算路径文件的大小 */
- (int)sizeAtPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *dict = [manager attributesOfItemAtPath:path error:nil];
    return [dict[NSFileSize] intValue];
}




@end
