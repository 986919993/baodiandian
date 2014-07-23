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

+ (void)initialize
{
    // 1.设置导航条的主题
    [self settingNavTheme];
    
    // 2.设置按钮的主题
    [self settingButtonTheme];
}
/**
 *  设置按钮的主题
 */
+ (void)settingButtonTheme
{
    // 拿到导航栏外观
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 当前手机是ios7以下时
    if (!iOS7) {
        // 设置外观的背景图片 默认状态
        [item setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    
    // 实例化一个可变的字典
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    // 在字典中记录一个文本属性文本颜色键 赋值一个菊花色
    md[UITextAttributeTextColor] = [UIColor orangeColor];
    // 在字典中记录一个文本属性文本沙盒
    md[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    // 在字典中记录一个文本属性的字体
    md[UITextAttributeFont] = [UIFont systemFontOfSize:16];
    // 给导航栏外观设置标题文本属性字典  普通状态
    [item setTitleTextAttributes:md forState:UIControlStateNormal];
    
    
    // 实例化一个可变字典 通过上一个字典(这里要给高亮状态赋值拿到普通状态字典追加一条)
    NSMutableDictionary *mdHig = [NSMutableDictionary dictionaryWithDictionary:md];
    // 给高亮字典添加一条文本属性文本颜色键 赋值一个红色
    mdHig[UITextAttributeTextColor] = [UIColor redColor];
    // 赋值到导航栏外观 高亮状态
    [item setTitleTextAttributes:mdHig forState:UIControlStateHighlighted];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 当导航控制器中的子控制器大于0时
    if (self.viewControllers.count >0) {
        // 隐藏底部TabBar控制器
        viewController.hidesBottomBarWhenPushed = YES;
        // 为Nav导航栏添加一个左边的导航按钮,传入默认状态按钮,高亮状态按钮,点击事件的监听者,点击事件的监听方法
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        // 为Nav导航栏添加一个右边的导航按钮,传入默认状态按钮,高亮状态按钮,点击事件的监听者,点击事件的监听方法
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    // 调用父类的push方法
    [super pushViewController:viewController animated:YES];
}

/**
 *  设置导航条的主题
 */
+ (void)settingNavTheme
{
    // 拿到导航栏的外观
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 当是ios7以下时
    if (!iOS7) {
        // 1.设置导航条背景图片
        [navBar setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        // 2.设置导航条标题的属性
        NSMutableDictionary *md = [NSMutableDictionary dictionary];
        // 文字颜色
        md[UITextAttributeTextColor] = [UIColor blackColor];
        // 文字偏移位
        md[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
        // 文字字体大小
        md[UITextAttributeFont] = [UIFont systemFontOfSize:20];
        [navBar setTitleTextAttributes:md];
    }
}
/**
 *  点击左边返回按钮的响应事件
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}
/**
 *  点击右边更多按钮的响应事件
 */
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 只有在ios7以上时才用清空代理
    if (iOS7) {          // 手势 识别器
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
@end
