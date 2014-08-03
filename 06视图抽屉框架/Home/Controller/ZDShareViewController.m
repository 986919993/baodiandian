//
//  ZDHomeViewController.m
//  新浪微博
//
//  Created by Dong on 14-7-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDShareViewController.h"
#import "ZDAccountTool.h"
#import "ZDAccount.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ZDStatus.h"
#import "ZDStatusFrame.h"
#import "MJExtension.h"
#import "ZDUser.h"
#import "ZDStatusCell.h"

@interface ZDShareViewController ()

/** 保存所有微博数据 */
@property (nonatomic,strong) NSMutableArray *statusFrame;

@end

static NSString *ID = @"cell";

@implementation ZDShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 加载设置Nav导航条按钮
    [self setupNav];
    // 加载下拉刷新&上拉刷新
    [self setupRefresh];
}

- (NSMutableArray *)statusFrame
{
    if (_statusFrame == nil) {
        _statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
}
/** 加载上拉刷新和下拉刷新 */
- (void)setupRefresh
{
    // 添加Header上拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewsStutases)];
    // 添加Footer上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStutases)];
    // 首次登陆转菊花
    [self.tableView headerBeginRefreshing];
    
    // 3.设置其它属性
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = ZDColor(219, 219, 219);
    //设置额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, ZDPadding, 0);
}

/**
 *  上拉刷新
 */
- (void)loadMoreStutases
{
}

/**
 *  通过微博工具类,向新浪微博服务器发送请求获取用户关注的所有动态
 */
- (void)loadNewsStutases
{
}

/**
 *  添加Nav控制栏的左右两个按钮
 */
- (void)setupNav
{
    // 设置一个控制栏右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted" target:self action:@selector(saoyisao)];
    // 设置一个控制栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friend)];
}


- (void)saoyisao
{
    NSLog(@"扫一扫");
}

- (void)friend
{
    NSLog(@"朋友");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建自定义cell
    ZDStatusCell *cell = [ZDStatusCell cellWithTableView:tableView];
    // 设置数据
    cell.statusFrame = self.statusFrame[indexPath.row];
    ZDLog(@"%f",cell.statusFrame.cellHeight);
    return cell;
}

/** 开始下拉刷新 */
- (void)refresh
{
    if (self.tabBarItem.badgeValue.intValue) {
        [self.tableView headerBeginRefreshing];
    }else{
        // 自动滚到最顶部
        [self.tableView scrollToRowAtIndexPath:0 atScrollPosition:0 animated:YES];
    }
}

/** 显示当前更新条数 */
- (void)showNewsStatusCount:(int)count
{
    // 实例化一个Label
    UILabel *label = [[UILabel alloc]init];
    // 给文本区域添加一个背景颜色
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"timeline_new_status_background"]];
    // 将label添加到导航控制器的View上并且在导航条之下
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 设置透明度
    label.alpha = 0;
    // 设置文本颜色
    label.textColor = [UIColor whiteColor];
    // 设置对齐样式
    label.textAlignment = NSTextAlignmentCenter;
    // 设置高度
    label.height = 35;
    // 设置宽度
    label.width = self.view.width;
    // 设置X值
    label.x = 0;
    // 设置Y值
    label.y = 64 - label.height;
    // 判断调用此方法时是否更新到数据
    if (count != 0) {
        // 设置更新到新微博时文本
        label.text = [NSString stringWithFormat:@"更新到%d条新数据",count];
    }else{
        // 设置没更新到微博时
        label.text = @"没有更多信息";
    }
    // 动画效果慢慢显示出这块文字
    [UIView animateWithDuration:2 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        label.alpha = 1;
    } completion:^(BOOL finished) {
        // 动画完成后延迟1秒执行隐藏动画
        [UIView animateWithDuration:1 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

/**
 *  当用户点击某一行时
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statusFrame[indexPath.row] cellHeight];
}


@end
