//
//  NewsReadingViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDFindViewController.h"
#import "ZDSearchBar.h"
#import "ZDItemCell.h"
#import "ZDItemDetailViewController.h"

#define kMaxOffset 160
#define kYOffset 80             // Y轴最大调整量
#define kRightXOffset 140       // 向右移动的最大X偏移量
#define kLeftXOffset -190       // 向左移动的最大Y偏移量

@interface ZDFindViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) NSArray *dataList;

@end
static NSString *itemID = @"itemCell";
@implementation ZDFindViewController

- (NSArray *)dataList{
    
    if (!_dataList) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"DataList.plist" ofType:nil];
        _dataList = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 注册标题NIB
    UINib *itemNib = [UINib nibWithNibName:@"ZDItemCell" bundle:nil];
    [self.tableView registerNib:itemNib forCellReuseIdentifier:itemID];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDItemCell *cell = [tableView dequeueReusableCellWithIdentifier:itemID];
    cell.dict = self.dataList[indexPath.row];
    
    if (indexPath.row%2 ==1) {
        cell.backgroundColor = ZDColor(240, 240, 240);
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataList[indexPath.row];
    ZDItemDetailViewController *itemDetail = [[ZDItemDetailViewController alloc]init];
    itemDetail.dict = dict;
    [self.navigationController pushViewController:itemDetail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ZDItemCell cellHeight];
}
@end
