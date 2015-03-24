//
//  ZDEnglishViewController.m
//  IOSBaoDian
//
//  Created by Dong on 14-8-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDEnglishViewController.h"
#import "ZDItemCell.h"
#import "ZDItemDetailViewController.h"
#import "ZDDataTool.h"
#import "FMDB.h"

@interface ZDEnglishViewController ()
@property (nonatomic,strong) NSMutableArray *dataList;
//@property (nonatomic, strong) NSArray *menus;
@property (nonatomic,assign) BOOL settingEdge;
@property (nonatomic,copy) NSString *searchText;
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UIButton *homeButton;
@end
static NSString *itemID = @"itemCell";

@implementation ZDEnglishViewController
/** 首次加载所有数据 */
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [ZDDataTool dataWithItemType:@"4"];
    }
    return _dataList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setting];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftmenu_geren2"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
    [self.navigationItem.leftBarButtonItem setCustomView:self.homeButton];
}
- (UIButton *)homeButton{
    if (!_homeButton) {
        _homeButton = [[UIButton alloc] init];
        _homeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_homeButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_geren2"] forState:UIControlStateNormal];
        [_homeButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_geren1"] forState:UIControlStateHighlighted];
        //        [_postButton setTitle:@"发帖" forState:UIControlStateNormal];
        _homeButton.frame = CGRectMake(0, 0, 36, 36);
        [_homeButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homeButton;
}
- (void)setting{
    // 注册标题NIB
    UINib *itemNib = [UINib nibWithNibName:@"ZDItemCell" bundle:nil];
    [self.tableView registerNib:itemNib forCellReuseIdentifier:itemID];
    // 解决IOS7布局,只在IOS7执行
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickZan) name:@"clickZan" object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)clickZan{
    _dataList = [ZDDataTool dataWithItemType:@"4"];
    [self.tableView  reloadData];
}

#pragma mark tableView代理方法
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

/** 选中某一行,将本行的数据传过去 */
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
