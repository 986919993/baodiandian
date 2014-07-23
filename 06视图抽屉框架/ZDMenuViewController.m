//
//  ZDMenuViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDMenuViewController.h"
#import "ZDMenuCell.h"
@interface ZDMenuViewController ()

/** 数据源 */
@property (nonatomic,strong) NSArray *menus;

@end

@implementation ZDMenuViewController

#pragma mark 懒加载
- (NSArray *)menus{
    if (!_menus) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"navmenu.plist" ofType:nil];
        _menus = [NSArray arrayWithContentsOfFile:path];
    }
    return _menus;
}

#pragma mark tableView代理方法
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menus.count;
}
- (void)setupNav
{
    // 设置一个控制栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"sidebar_nav_photo" highlightedImage:@"sidebar_nav_photo" target:self action:@selector(home)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"home" highlightedImage:@"home" target:self action:@selector(btn)];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZDMenuCell *cell = [ZDMenuCell cellWithTableView:tableView];
    NSDictionary *dict = self.menus[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageWithNamed:dict[@"imageName"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.menus[indexPath.row];
//    NSLog(@"%@",dict);
    if([self.menuDelegate respondsToSelector:@selector(menuViewControllerDidSelectedDict:)])
    {
        [self.menuDelegate menuViewControllerDidSelectedDict:dict];
    }
}


#pragma mark 系统加载完毕后方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 42;
    [self setupNav];
}
@end
