//
//  CZMainViewController.m
//  05-网易新闻
//
//  Created by LNJ on 14-7-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDInfoViewController.h"
#import "AFNetworking.h"
#import "CZBaseCell.h"
#import "CZTitleCell.h"
#import "CZNormalCell.h"
#import "ZDDetailViewController.h"
#import "ZDHttpTool.h"
#import "MBProgressHUD+NJ.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "CZPhotosCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "ZDInfoCacheTool.h"
#import "UIImage+NJ.h"


static NSString *TitleCellID = @"TitleCell";
static NSString *NormalCellID = @"NormalCell";
static NSString *PhotosID = @"photosCell";

@interface ZDInfoViewController () <CZTitleCellDelegate>
/** 数据列表 */
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic,assign) BOOL isMore;

@property (nonatomic,strong) CZTitleCell *titleCell;

@property (nonatomic,assign) BOOL isScience;
@property (nonatomic,assign) BOOL settingEdge;
@property (nonatomic,assign) BOOL huancun;
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UIButton *homeButton;
@end

@implementation ZDInfoViewController




- (void)setDataList:(NSMutableArray *)dataList
{
    _dataList = dataList;
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizableImageNamed:@"viewBG"]];
    self.title = @"新闻资讯";
    [self setupRefresh];
    [self regCellNibs];
    self.huancun = YES;
    //    [self.navigationItem.leftBarButtonItem setAction:@selector(presentLeftMenuViewController:)];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
    //                                                                             style:UIBarButtonItemStylePlain
    //                                                                            target:self
    //                                                                            action:@selector(presentLeftMenuViewController:)];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
    //                                                                              style:UIBarButtonItemStylePlain
    //                                                                             target:self
    //                                                                             action:@selector(presentRightMenuViewController:)];
    
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
//- (UIButton *)postButton{
//    if (!_postButton) {
//        _postButton = [[UIButton alloc] init];
//        _postButton.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_postButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_pingjia2"] forState:UIControlStateNormal];
//        [_postButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_pingjia1"] forState:UIControlStateHighlighted];
//        _postButton.frame = CGRectMake(0, 0, 36, 36);
//        [_postButton addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _postButton;
//}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//    if (iOS7 && !self.settingEdge) {
//        self.tableView.contentInset = UIEdgeInsetsMake(2, 0, 50, 0);
//        _settingEdge = YES;
//    }
    if(iOS7)    {
        
        self.edgesForExtendedLayout = NO;
        
        self.navigationController.navigationBar.opaque=YES;
        
    }
}

- (void)titleCellDidSelect:(CZTitleCellSelectedNavType)navType{
    if (navType == CZTitleCellSelectedNavTypeIphone) {
        self.isScience = NO;
        [self loadIphoneNews];
    }else {
        self.isScience = YES;
        [self loadScienceNews];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    // TODO 做些过滤
    return NO;
}


/** 加载上拉刷新和下拉刷新 */
- (void)setupRefresh
{
    // 添加Header上拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadIphoneNews)];
    // 添加Footer上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreIphoneNews)];
    // 首次登陆转菊花
    [self.tableView headerBeginRefreshing];
//    设置额外的滚动区域
//    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 64, 0);
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)loadIphoneNews{
    NSString *url = [NSString stringWithFormat:ZDIphoneNew20];
    if (self.isScience) {
        url = [NSString stringWithFormat:ZDKeJiNew20];
    }
    NSDictionary *dicts = [ZDInfoCacheTool newsStatusWith:@"1" index:1];
    //    NSLog(@"%d",arrayM.count);
    NSInteger inter = [self netWork];
    
    if (inter == 0) {
        NSMutableArray  *array = dicts[ZDIPhoneInfo];
        self.dataList = array;
        self.isMore = NO;

        [self.tableView headerEndRefreshing];
    }else{
        [ZDHttpTool getWithUrl:url params:nil success:^(NSDictionary *dict) {
            
            NSMutableArray *array = nil;
            //        NSLog(@"%@",dict);
            if (self.isScience) {
                array = dict[ZDScience];
                
            }else{
                array =dict[ZDIPhoneInfo];
                [ZDInfoCacheTool saveStatus:dict date:@"s"];
            }
            self.dataList = array;
            self.isMore = NO;
            
            [self.tableView headerEndRefreshing];
        } failure:^(NSError *error) {
            [self.tableView headerEndRefreshing];
            
        }];
        
    }
}
- (void)loadMoreIphoneNews{
    if (self.isMore) {
        [self.tableView footerEndRefreshing];
        [MBProgressHUD showMessage:@"暂无更多..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        return;
    }
    self.isMore = YES;
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1348649654285/20-40.html"];
    if (self.isScience) {
        url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1348649580692/20-40.html"];
    }

    [ZDHttpTool getWithUrl:url params:nil success:^(NSDictionary *dict) {
        
//        定义可变数组保存statusFrame模型
//        NSMutableArray *model = [[NSMutableArray alloc]init];
        
        NSMutableArray *array = dict[ZDIPhoneInfo];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        if (self.isScience) {
            array = dict[@"T1348649580692"];
            [temp addObjectsFromArray:self.dataList];
            [temp addObjectsFromArray:array];

            self.dataList = temp;
        }else{
            [temp addObjectsFromArray:self.dataList];
            [temp addObjectsFromArray:array];
            self.dataList = temp;
        }
        
        [self.tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];
    }];
}
- (void)loadScienceNews{
    [ZDHttpTool getWithUrl:@"http://c.3g.163.com/nc/article/headline/T1348649580692/0-20.html" params:nil success:^(NSDictionary *dict) {
        self.dataList = dict[ZDScience];
        self.isMore = NO;
        self.isScience = YES;
        [self.tableView headerEndRefreshing];
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

// 为表格注册可重用的cell
- (void)regCellNibs
{
    // 注册标题NIB
    UINib *titleNib = [UINib nibWithNibName:@"CZTitleCell" bundle:nil];
    [self.tableView registerNib:titleNib forCellReuseIdentifier:TitleCellID];
    
    // 注册其他NIB
    UINib *normalNib = [UINib nibWithNibName:@"CZNormalCell" bundle:nil];
    [self.tableView registerNib:normalNib forCellReuseIdentifier:NormalCellID];
    
    // 注册图集NIB
    UINib *PhotosNib = [UINib nibWithNibName:@"CZPhotosCell" bundle:nil];
    [self.tableView registerNib:PhotosNib forCellReuseIdentifier:PhotosID];

}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CZBaseCell *cell = nil;
    NSString *isPhotos = self.dataList[indexPath.row][@"docid"];
    NSArray *array = self.dataList[indexPath.row][@"imgextra"];
    NSRange range = [isPhotos rangeOfString:@"_" options:NSBackwardsSearch];
//    NSLog(@"%@",isPhotos);
    // 1. 如果是第0行，显示标题行
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:TitleCellID];
        cell = (CZTitleCell *)cell;
        CZTitleCell *titleCell = (CZTitleCell *)cell;
        titleCell.delegate = self;
    }else if (range.length != 0 | array.count!= 0 ){
        cell = [tableView dequeueReusableCellWithIdentifier:PhotosID];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID];
    }
    // 设置cell
    cell.dict = self.dataList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *isPhotos = self.dataList[indexPath.row][@"docid"];
    NSArray *array = self.dataList[indexPath.row][@"imgextra"];
//    NSRange range = [isPhotos rangeOfString:@"_" options:NSBackwardsSearch];
    if (indexPath.row == 0) {
        return [CZTitleCell rowHeight];
    } else if(array.count!= 0){
        return [CZPhotosCell rowHeight];
    }else {
        return [CZNormalCell rowHeight];
    }
}

// 表格行选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    // imgextra
    NSString *isPhotos = self.dataList[indexPath.row][@"docid"];
    NSRange range = [isPhotos rangeOfString:@"_" options:NSBackwardsSearch];
    
    if (range.length != 0 ) {
        NSMutableArray *array = [NSMutableArray array];
        
        UIImageView *imageView1 = [[UIImageView alloc]init];
        UIImageView *imageView2 = [[UIImageView alloc]init];
        UIImageView *imageView3 = [[UIImageView alloc]init];
        
        NSString *image1 = self.dataList[indexPath.row][@"imgsrc"];
        NSString *image2 = self.dataList[indexPath.row][@"imgextra"][0][@"imgsrc"];
        NSString *image3 = self.dataList[indexPath.row][@"imgextra"][1][@"imgsrc"];
        
        NSURL *url1 = [NSURL URLWithString:image1];
        [imageView1 sd_setImageWithURL:url1];
        NSURL *url2 = [NSURL URLWithString:image2];
        [imageView2 sd_setImageWithURL:url2];
        NSURL *url3 = [NSURL URLWithString:image3];
        [imageView3 sd_setImageWithURL:url3];
        MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc]init];
        
        MJPhoto *photo1 = [[MJPhoto alloc]init];
        photo1.url = [NSURL URLWithString:image1];
        photo1.srcImageView = imageView1;
        [array addObject:photo1];
        
        MJPhoto *photo2 = [[MJPhoto alloc]init];
        photo2.url = [NSURL URLWithString:image2];
        photo2.srcImageView = imageView2;
        [array addObject:photo2];
        
        MJPhoto *photo3 = [[MJPhoto alloc]init];
        photo3.url = [NSURL URLWithString:image3];
        photo3.srcImageView = imageView3;
        [array addObject:photo3];

        photoBrowser.photos = array;
        photoBrowser.currentPhotoIndex = 0;
        [photoBrowser show];
    }else {
    
        // 取出数据字典
        NSDictionary *dict = self.dataList[indexPath.row];
        // 1. 取出url
        NSString *url = dict[ZDURLKey];
        // 1> 取出url中的xxx.html
        // lastPathComponent取出最后一项内容
        NSString *fileName = [[url lastPathComponent] stringByDeletingPathExtension];
        
        // 2> 拼接新的URL的字符串
        //    NSString *articleURLStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html", fileName];
        for (UIViewController *controller in self.childViewControllers) {
            // 将子视图控制器的视图从父视图中删除
            [controller.view removeFromSuperview];
            // 将视图控制器从父视图控制器中删除
            [controller removeFromParentViewController];
        }
        // 新建文档视图控制器
        ZDDetailViewController *vc = [[ZDDetailViewController alloc] init];
        //    vc.articleURLStr = articleURLStr;
        vc.docid = fileName;
        vc.title = @"详细内容";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
/** 检测当前网络 0没网  1移动3G  2wifi */
- (NSInteger )netWork{
    Reachability *reacha = [[Reachability alloc]init];
    NSInteger inter = reacha.currentNetwork;
    if (inter == 0) {
//        [self showNetMessage:@"网络不给力.."];
        return inter;
    }else if (inter == 1){
//        [self showNetMessage:@"当前为3G网络"];
        return inter;
    }else if (inter == 2){
//        [self showNetMessage:@"当前Wi-Fi已连接"];
        return inter;
    }
    return inter;
}
@end
