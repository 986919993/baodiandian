//
//  ZDRootViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDRootViewController.h"
#import "ZDHomeViewController.h"
#import "ZDMenuViewController.h"
#import "ZDNavViewController.h"
#import "ZDInfoViewController.h"
#import "ZDFindViewController.h"
#import "ZDSpecialViewController.h"
#import "MBProgressHUD+NJ.h"
#import "Reachability.h"

@interface ZDRootViewController () <ZDMenuViewControllerDelegate>

/** weak，菜单控制器 */
@property (nonatomic,weak) ZDHomeViewController *home;

@property (nonatomic, weak) ZDSpecialViewController *specialVIew;

@end

@implementation ZDRootViewController

- (void)loadView{

    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    NSInteger inter = arc4random_uniform(4);
    NSString *imageName = [NSString  stringWithFormat:@"root2.png"];
    imageView.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView];
    
    ZDMenuViewController *menu  = [[ZDMenuViewController alloc]init];
    [self addChildViewController:menu];
    [self.view addSubview:menu.view];
    menu.menuDelegate = self;
    
    ZDHomeViewController *home = [[ZDHomeViewController alloc]init];
    ZDNavViewController *nav = [[ZDNavViewController alloc]initWithRootViewController:home];
    nav.navigationBar.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    _home = home;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    ZDSpecialViewController *specialView = [[ZDSpecialViewController alloc] init];
    [self addChildViewController:specialView];
    [self.view addSubview:specialView.view];
    self.specialVIew = specialView;
    //  设置登录特效
    [self setupSpecialView];
}
/**
 *  设置登录特效
 */
- (void)setupSpecialView{
    [UIView animateWithDuration:1.5f animations:^{
        self.specialVIew.view.alpha = 0;
        self.specialVIew.view.transform = CGAffineTransformMakeScale(1.6, 1.6);
    }completion:^(BOOL finished) {
        [self.specialVIew removeFromParentViewController];
        [self.specialVIew.view removeFromSuperview];
        [self netWork];
    }];
}
/** 检测当前网络 0没网  1移动3G  2wifi */
- (void)netWork{
    Reachability *reacha = [[Reachability alloc]init];
    NSInteger inter = reacha.currentNetwork;
    if (inter == 0) {
        [self showNetMessage:@"当前无网络"];
    }else if (inter == 1){
        [self showNetMessage:@"当前为移动网络"];
    }else if (inter == 2){
//        [self showNetMessage:@"当前Wi-Fi已连接"];
    }
}
- (void)showNetMessage:(NSString *)message{
    [MBProgressHUD showError:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}


//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleDefault;
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)menuViewControllerDidSelectedDict:(NSDictionary *)dict{
    self.home.menuDict= dict;
}

@end
