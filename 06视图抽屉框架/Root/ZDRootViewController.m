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

@interface ZDRootViewController () <ZDMenuViewControllerDelegate>

/** weak，菜单控制器 */
@property (nonatomic,weak) ZDHomeViewController *home;

@end

@implementation ZDRootViewController

- (void)loadView{

    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bg.png"];
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
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches-- root");
    [self.view endEditing:YES];
}

- (void)menuViewControllerDidSelectedDict:(NSDictionary *)dict{

    self.home.menuDict= dict;
//    NSLog(@"%p",self.home);
}

@end
