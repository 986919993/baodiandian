//
//  ZDShareDetailViewController.m
//  IOSBaoDian
//
//  Created by Dong on 14-8-13.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDShareDetailViewController.h"
#import "ZDShareCell.h"
#import "ZDShareFrame.h"

@interface ZDShareDetailViewController ()

@end

@implementation ZDShareDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setting];
}
- (void)setting{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDShareCell *cell = [ZDShareCell cellWithTableview:tableView];
    cell.shareFrame = self.shareFrame;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.shareFrame.cellHeight;
}

@end
