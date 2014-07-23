//
//  ZDInfoTableViewController.m
//  兄弟连
//
//  Created by Dong on 14-7-3.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDInfoTableViewController.h"
#import "ZDHeardCell.h"
#import "ZDInfoCell.h"
#import "ZDDetailViewController.h"
#import "ZDInfoModel.h"


static NSString *heardID = @"heradCell";
static NSString *infoID = @"infoCell";
@interface ZDInfoTableViewController ()

/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation ZDInfoTableViewController

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [ZDInfoModel infoModel];
    }
    return _dataList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *heardNib = [UINib nibWithNibName:@"ZDHeardCell" bundle:nil];
    [self.tableView registerNib:heardNib forCellReuseIdentifier:heardID];
    UINib *infoNib = [UINib nibWithNibName:@"ZDInfoCell" bundle:nil];
    [self.tableView registerNib:infoNib forCellReuseIdentifier:infoID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger x = self.dataList.count - indexPath.row;
    ZDBaseCell *cell = nil;
    if (indexPath.row==0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:heardID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        cell = [self.tableView dequeueReusableCellWithIdentifier:infoID];
        ZDInfoCell *infoCell = (ZDInfoCell *)cell;
        infoCell.dict = self.dataList[x];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDDetailViewController *detail = [[ZDDetailViewController alloc]init];
    detail.infoModel = self.dataList[self.dataList.count - indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 140;
    }
    return 74;
}



@end
