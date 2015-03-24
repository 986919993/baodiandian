//
//  ZDMenuViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDMenuViewController.h"
#import "ZDMenuCell.h"
#import "RESideMenu.h"
#import "ZDInfoViewController.h"
#import "ZDUIViewController.h"
#import "ZDMemoryViewController.h"
#import "ZDNetViewController.h"
#import "ZDFoundationViewController.h"
#import "ZDEnglishViewController.h"
#import "ZDHotViewController.h"
#import "ZDXiangMuViewController.h"
#import "ZDFindViewController.h"
#import "ZDShareViewController.h"
#import "ZDMoreViewController.h"

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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZDMenuCell *cell = [ZDMenuCell cellWithTableView:tableView];
    NSDictionary *dict = self.menus[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageWithNamed:dict[@"imageName"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSDictionary *dict = self.menus[indexPath.row];
//    if([self.menuDelegate respondsToSelector:@selector(menuViewControllerDidSelectedDict:)])
//    {
//        [self.menuDelegate menuViewControllerDidSelectedDict:dict];
//    }
//    NSString *className = menuDict[@"className"];
//    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDInfoViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDFindViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDShareViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDUIViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDMemoryViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 5:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDNetViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 6:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDFoundationViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 7:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDEnglishViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 8:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDHotViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 9:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDXiangMuViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 10:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ZDMoreViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}


#pragma mark 系统加载完毕后方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (Inch4) {
        self.tableView.rowHeight = 42;
    }else{
        self.tableView.rowHeight = 35;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
}
@end
