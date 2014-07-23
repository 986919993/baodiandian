//
//  NewsNewsViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "NewsNewsViewController.h"

@interface NewsNewsViewController ()

@end

@implementation NewsNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    ZDLog(@"销毁News");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    self.title = @"xx";
	self.view.backgroundColor = [UIColor grayColor];
}
/**
 *  添加Nav控制栏的左右两个按钮
 */
- (void)setupNav
{
    // 设置一个控制栏左边按钮
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"sidebar_nav_photo" highlightedImage:@"sidebar_nav_photo" target:self action:@selector(home)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem.title = @"返回";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithNamed:@"home"] style:UIBarButtonItemStylePlain target:self action:@selector(home)];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"home" highlightedImage:@"home" target:self action:@selector(btn)];
//    self.navigationItem.leftBarButtonItem.title = @"sdfs";
//    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor redColor]];
//    NSLog(@"%@",self.navigationItem.leftBarButtonItem.title);
}
- (void)btn{};
- (void)home
{
    ZDLog(@"Home");
}

@end
