//
//  ZDFindViewController.m
//  新浪微博
//
//  Created by Dong on 14-7-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDCommonViewController.h"
#import "ZDCommonGroup.h"
#import "ZDCommonItem.h"
#import "ZDCommonCell.h"

@interface ZDCommonViewController ()

@property (nonatomic,strong) NSMutableArray *groups;

@property (nonatomic,assign) BOOL settingEdge;

@end

@implementation ZDCommonViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTable];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupTable
{
    // 背景颜色
    self.tableView.backgroundColor = ZDGlobalColor;
    // 无分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 分组之间的差距
    self.tableView.sectionFooterHeight = 15;
    self.tableView.sectionHeaderHeight = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (iOS7 && !self.settingEdge) {
        self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0);
        _settingEdge = YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZDCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDCommonGroup *group = self.groups[indexPath.section];
    ZDCommonItem *item = group.items[indexPath.row];
    if (item.destVC) {
        UIViewController *vc = [[item.destVC alloc]init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (item.opertion) {
        item.opertion();
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDCommonCell *cell = [ZDCommonCell cellWithTableView:tableView];
    ZDCommonGroup *group = self.groups[indexPath.section];
    ZDCommonItem *item = group.items[indexPath.row];
    cell.item = item;
    cell.indexPath = indexPath;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZDCommonGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZDCommonGroup *group = self.groups[section];
    return group.header;
}

- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [[NSMutableArray alloc]init];
    }
    return _groups;
}

- (ZDCommonGroup *)addGroup
{
    ZDCommonGroup *group = [[ZDCommonGroup alloc]init];
    [self.groups addObject:group];
    return group;
}
- (ZDCommonCheckGroup *)addCheckGroup
{
    ZDCommonCheckGroup *checkGroup = [[ZDCommonCheckGroup alloc]init];
    [self.groups addObject:checkGroup];
    return checkGroup;
}
/**
 *  后去对应的组模型
 *
 *  @param section 选中的组
 */
- (ZDCommonCheckGroup *)groupWithSection:(NSInteger)section
{
    return self.groups[section];
}

@end
