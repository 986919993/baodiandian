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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZDMenuCell *cell = [ZDMenuCell cellWithTableView:tableView];
    NSDictionary *dict = self.menus[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageWithNamed:dict[@"imageName"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.menus[indexPath.row];
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
    if (Inch4) {
        self.tableView.rowHeight = 42;
    }else{
        self.tableView.rowHeight = 35;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
//    self.tableView selectRowAtIndexPath:<#(NSIndexPath *)#> animated:<#(BOOL)#> scrollPosition:<#(UITableViewScrollPosition)#>
}
@end
