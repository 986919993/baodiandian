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
#import "ZDDataTool.h"
#import "FMDB.h"
#import "ZDFindHeaderView.h"
#import "UIView+Add.h"

@interface ZDFindViewController () 

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;
@property (nonatomic, strong) NSArray *menus;
@property (nonatomic,assign) BOOL settingEdge;
@property (nonatomic,copy) NSString *searchText;
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UIButton *homeButton;
@end
static NSString *itemID = @"itemCell";

@implementation ZDFindViewController

/** 首次加载所有数据 */
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [ZDDataTool dataList];
    }
    return _dataList;
}

/** 当监听到textfield值改变 */
- (void)textChanged:(NSNotification *)note{
    NSString *text = note.object;
    _dataList = nil;
    self.searchText = text;
    _dataList = [ZDDataTool dataWithSearch:text];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    self.navigationController.navigationBar.hidden = YES;
    
    if (iOS7 && !self.settingEdge) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
        _settingEdge = YES;
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
/** 监听滚动, 隐藏键盘 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UITextField *textField =  [UIView findFistResponder:self.view];
    [textField resignFirstResponder];
}

- (void)setting{
    // 注册标题NIB
    UINib *itemNib = [UINib nibWithNibName:@"ZDItemCell" bundle:nil];
    [self.tableView registerNib:itemNib forCellReuseIdentifier:itemID];
    // 解决IOS7布局,只在IOS7执行
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 监听textField值改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:@"text" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickZan) name:@"clickZan" object:nil];
    // 设置HeaderView
    self.tableView.tableHeaderView = [ZDFindHeaderView findHeaderView];
}
- (void)clickZan{
    if (self.searchText.length != 0) {
        _dataList = [ZDDataTool dataWithSearch:self.searchText];
    }else{
        _dataList = [ZDDataTool dataList];
    }
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
