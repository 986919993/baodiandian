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
#import "MJExtension.h"
#import "ZDShareModel.h"
#import "ZDShareCell.h"
#import "ZDShareFrame.h"
#import "ZDPostViewController.h"
#import "ZDLoginViewController.h"
#import "ZDShareDetailViewController.h"
#import "ZDShareButton.h"
#import "ZDShareTool.h"
#import "ZDShareCacheTool.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobObject.h>//"BmobObject.h"
#import <BmobSDK/BmobQuery.h>//"BmobQuery.h"
#import <BmobSDK/BmobFile.h>
#import "Reachability.h"
#import "MBProgressHUD+NJ.h"

@interface ZDShareViewController ()

/** 保存所有微博数据 */
@property (nonatomic,strong) NSMutableArray *statusFrame;
@property (nonatomic,strong) NSMutableArray *allStatus;
@property (nonatomic, weak) BmobQuery *query;
@property (nonatomic,assign) BOOL settingEdge;
@property (nonatomic, strong) BmobUser *user;
@property (nonatomic,assign) BOOL huancun;
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UIButton *homeButton;
@end

static NSString *ID = @"cell";

@implementation ZDShareViewController
int StatusesSkip = 0;
/**
 *  用户
 */
- (BmobUser *)user{
    if (!_user) {
        _user = [[BmobUser alloc] init];
    }
    return _user;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 加载设置Nav导航条按钮
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"分享交流";
    // 加载下拉刷新&上拉刷新
    [self setupRefresh];
    self.tableView.alwaysBounceVertical = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(send) name:@"post" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareBtnClick) name:@"shareBtnClick" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuangBtnClick:) name:@"shuangBtnClick" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kengBtnClick:) name:@"kengBtnClick" object:nil];
    self.huancun = YES;
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

/** 监听Nav写信息按钮 */
- (void)send{
    if (![ZDAccountTool account].nickname.length) {
        ZDPostViewController *compose = [[ZDPostViewController alloc]init];
        [self.navigationController pushViewController:compose animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            
            break;
        }
        case 1:{
            
            break;
        }
        default:
            
            break;
    }
}


/** 加载上拉刷新和下拉刷新 */
- (void)setupRefresh
{
    [self loadNewsStutases];
    // 添加Header上拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewsStutases)];
    // 添加Footer上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStutases)];
    // 首次登陆转菊花
//    [self.tableView headerBeginRefreshing];
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
    StatusesSkip += 10;
    self.query.skip = StatusesSkip;
   
    //执行查询
    NSMutableArray *bombStatuses = [NSMutableArray array];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"ios_statusese"];
    //按updatedAt进行降序排列
    [bquery orderByDescending:@"createdAt"];
    //返回最多20个结果
    bquery.limit = 10;
    bquery.skip = StatusesSkip;
    ZDShareFrame *share = self.statusFrame.lastObject;
    
    /** 从本地获取是否有数据 */
    NSMutableArray *arrayM = [[ZDShareCacheTool moreStatusWith:share.statesesModel.createTime index:StatusesSkip] mutableCopy];
//    NSLog(@"%d",arrayM.count);
    Reachability *reacha = [[Reachability alloc]init];
    NSInteger inter = reacha.currentNetwork;
    if (arrayM.count && inter == 0) {
        self.allStatus = nil;
        [self.allStatus addObjectsFromArray:self.statusFrame];
        [self.allStatus addObjectsFromArray:arrayM];
        self.statusFrame = self.allStatus;
        [self.tableView reloadData];
    }else{
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
         {
//             NSLog(@"%@",[NSThread currentThread]);
             //处理查询结果
             for (BmobObject *obj in array) {
                 ZDShareFrame *info  = [[ZDShareFrame alloc] init];
                 ZDShareModel *model = [[ZDShareModel alloc] init];
                 
                 model.objID = obj.objectId;
                 if ([obj objectForKey:@"title"]) {
                     model.title = [obj objectForKey:@"title"];
                 }
                 if ([obj objectForKey:@"icon"]) {
                     model.icon = [obj objectForKey:@"icon"];
                 }
                 if ([obj objectForKey:@"answer"]) {
                     model.answer  = [obj objectForKey:@"answer"];
                 }
                 if ([obj objectForKey:@"city"]) {
                     model.city = [obj objectForKey:@"city"];
                 }
                 if ([obj objectForKey:@"man"]) {
                     model.man = [[obj objectForKey:@"man"] boolValue];
                 }
                 if ([obj objectForKey:@"zan"]) {
                     model.shuang = [obj objectForKey:@"zan"];
                 }
                 if ([obj objectForKey:@"keng"]) {
                     model.keng = [obj objectForKey:@"keng"];
                 }
                 if ([obj objectForKey:@"ping"]) {
                     model.ping = [obj objectForKey:@"ping"];
                 }
                 
                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                 formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
                 model.fbTime = [formatter stringFromDate:obj.createdAt];
                 model.createTime =[formatter stringFromDate:obj.createdAt];
//                 model.createTime = obj.createdAt;
                 
                 if ([obj objectForKey:@"imageName"]) {
                     BmobFile *file = (BmobFile*)[obj objectForKey:@"imageName"];
                     model.imageName = file.url;
                 }
                 if ([obj objectForKey:@"imageName2"]) {
                     BmobFile *file = (BmobFile*)[obj objectForKey:@"imageName2"];
                     model.imageName2 = file.url;
                 }
                 if ([obj objectForKey:@"imageName3"]) {
                     BmobFile *file = (BmobFile*)[obj objectForKey:@"imageName3"];
                     model.imageName3 = file.url;
                 }
                 
                 NSDictionary *dict =  [model keyValues];
                 [ZDShareCacheTool saveStatus:dict date:model.createTime];
                 
                 info.statesesModel = model;
                 [bombStatuses addObject:info];
             }
             
             if (bquery.skip == 0) {
                 self.statusFrame = bombStatuses;
             }else{
                 self.allStatus = nil;
                 [self.allStatus addObjectsFromArray:self.statusFrame];
                 [self.allStatus addObjectsFromArray:bombStatuses];
                 self.statusFrame = self.allStatus;
             }

             [self.tableView reloadData];
         }];
    }
    [self.tableView footerEndRefreshing];
}

/**
 *  下拉刷新
 */
- (void)loadNewsStutases
{
    StatusesSkip = 0;
    self.query.skip = StatusesSkip;
    //执行查询
    NSMutableArray *bombStatuses = [NSMutableArray array];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"ios_statusese"];
    //按updatedAt进行降序排列
    [bquery orderByDescending:@"createdAt"];
    //返回最多20个结果
    bquery.limit = 10;
    bquery.skip = StatusesSkip;
    ZDShareFrame *share = self.statusFrame.lastObject;
    NSMutableArray *arrayM = [[ZDShareCacheTool newsStatusWith:share.statesesModel.createTime index:StatusesSkip]mutableCopy];
    Reachability *reacha = [[Reachability alloc]init];
    NSInteger inter = reacha.currentNetwork;

    if (inter == 0) {
        [self netWork];
        self.statusFrame = nil;
        self.statusFrame = arrayM;
        self.huancun = NO;
        [self.tableView reloadData];
    }else{
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
         {
             //处理查询结果
             for (BmobObject *obj in array) {
                 ZDShareFrame *info  = [[ZDShareFrame alloc] init];
                 ZDShareModel *model = [[ZDShareModel alloc] init];
                 
                 model.objID = obj.objectId;
                 if ([obj objectForKey:@"title"]) {
                     model.title = [obj objectForKey:@"title"];
                 }
                 if ([obj objectForKey:@"icon"]) {
                     model.icon = [obj objectForKey:@"icon"];
                 }
                 if ([obj objectForKey:@"answer"]) {
                     model.answer  = [obj objectForKey:@"answer"];
                 }
                 if ([obj objectForKey:@"city"]) {
                     model.city = [obj objectForKey:@"city"];
                 }
                 if ([obj objectForKey:@"man"]) {
                     model.man = [[obj objectForKey:@"man"] boolValue];
                 }
                 if ([obj objectForKey:@"zan"]) {
                     model.shuang = [obj objectForKey:@"zan"];
                 }
                 if ([obj objectForKey:@"keng"]) {
                     model.keng = [obj objectForKey:@"keng"];
                 }
                 if ([obj objectForKey:@"ping"]) {
                     model.ping = [obj objectForKey:@"ping"];
                 }
                 
                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                 formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
                 model.fbTime = [formatter stringFromDate:obj.createdAt];
                 model.createTime =[formatter stringFromDate:obj.createdAt];
                 
                 if ([obj objectForKey:@"imageName"]) {
                     BmobFile *file = (BmobFile*)[obj objectForKey:@"imageName"];
                     model.imageName = file.url;
                 }
                 if ([obj objectForKey:@"imageName2"]) {
                     BmobFile *file = (BmobFile*)[obj objectForKey:@"imageName2"];
                     model.imageName2 = file.url;
                 }
                 if ([obj objectForKey:@"imageName3"]) {
                     BmobFile *file = (BmobFile*)[obj objectForKey:@"imageName3"];
                     model.imageName3 = file.url;
                 }
                 
                 NSDictionary *dict =  [model keyValues];
                 [ZDShareCacheTool saveStatus:dict date:model.createTime];
                 
                 info.statesesModel = model;
                 [bombStatuses addObject:info];
             }
             
             if (bquery.skip == 0) {
                 self.statusFrame = bombStatuses;
             }else{
                 self.allStatus = nil;
                 [self.allStatus addObjectsFromArray:self.statusFrame];
                 [self.allStatus addObjectsFromArray:bombStatuses];
                 self.statusFrame = self.allStatus;
             }
            
             [self.tableView reloadData];
         }];
    }
    
    [self.tableView headerEndRefreshing];
    
}
/**
 *  刷新方法
 */
- (void)refreshStatusese:(int)skips{
}

#pragma mark 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDShareCell *cell = [ZDShareCell cellWithTableview:tableView];
    cell.shareFrame = self.statusFrame[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDShareFrame *shareFrame = self.statusFrame[indexPath.row];
    return shareFrame.cellHeight;
}

#pragma mark 代理方法
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ZDShareFrame *shareFrame = self.statusFrame[indexPath.row];
//    ZDShareDetailViewController *share = [[ZDShareDetailViewController alloc]init];
//    share.shareFrame = shareFrame;
//    [self.navigationController pushViewController:share animated:YES];
//}

#pragma mark 懒加载

- (NSMutableArray *)statusFrame{
    if (!_statusFrame) {
        _statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
}
- (NSMutableArray *)allStatus{
    if (!_allStatus) {
        _allStatus = [NSMutableArray array];
    }
    return _allStatus;
}

- (BmobQuery *)query{
    if (!_query) {
        _query = [BmobQuery queryWithClassName:@"ios_statusese"];
        //按updatedAt进行降序排列
        [_query orderByDescending:@"updatedAt"];
        //返回最多20个结果
        _query.limit = 10;
    }
    return _query;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 点击分享 */
- (void)shareBtnClick{

}

/** 点击爽 */
- (void)shuangBtnClick:(NSNotification *)note{
    // toView用nil值，代表UIWindow
    ZDShareButton *btn = note.object;
    NSIndexPath *indexPath =  btn.indexPath;
    NSInteger num = [btn.shuzi integerValue] ;
    num +=1;
    NSString *str = [NSString stringWithFormat:@"%d",num];
    [ZDShareTool updateZanWithObjectID:btn.objID zan:str];
    CGRect convertRect = [btn convertRect:btn.bounds toView:self.tableView];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_add1"]];
    CGFloat imageX = convertRect.origin.x+20;
    CGFloat imageY = convertRect.origin.y-10;
    CGFloat imageW = 25;
    CGFloat imageH = 25;
    imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    [self.view addSubview:imageView];
    [UIView animateWithDuration:0.6f animations:^{
        imageView.alpha = 0.5;
        imageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
#pragma mark  从服务器中获取最新的行数据更新.
        NSString *objID = btn.objID;
        ZDShareFrame *info  = [[ZDShareFrame alloc] init];
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"ios_statusese"];
        //查找ios_statusese表里面id为objID的数据
        [bquery getObjectInBackgroundWithId:objID block:^(BmobObject *object,NSError *error){
            if (error){
                //进行错误处理
            }else{
                //表里有id为0c6db13c的数据
                if (object) {
                    ZDShareModel *model = [[ZDShareModel alloc] init];
                    
                    model.objID = object.objectId;
                    if ([object objectForKey:@"title"]) {
                        model.title = [object objectForKey:@"title"];
                    }
                    if ([object objectForKey:@"icon"]) {
                        model.icon = [object objectForKey:@"icon"];
                    }
                    if ([object objectForKey:@"answer"]) {
                        model.answer  = [object objectForKey:@"answer"];
                    }
                    if ([object objectForKey:@"city"]) {
                        model.city = [object objectForKey:@"city"];
                    }
                    if ([object objectForKey:@"man"]) {
                        model.man = [[object objectForKey:@"man"] boolValue];
                    }
                    if ([object objectForKey:@"zan"]) {
                        model.shuang = [object objectForKey:@"zan"];
                    }
                    if ([object objectForKey:@"keng"]) {
                        model.keng = [object objectForKey:@"keng"];
                    }
                    if ([object objectForKey:@"ping"]) {
                        model.ping = [object objectForKey:@"ping"];
                    }
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
                    model.fbTime = [formatter stringFromDate:object.createdAt];
                    model.createTime =[formatter stringFromDate:object.createdAt];
                    
                    if ([object objectForKey:@"imageName"]) {
                        BmobFile *file = (BmobFile*)[object objectForKey:@"imageName"];
                        model.imageName = file.url;
                    }
                    if ([object objectForKey:@"imageName2"]) {
                        BmobFile *file = (BmobFile*)[object objectForKey:@"imageName2"];
                        model.imageName2 = file.url;
                    }
                    if ([object objectForKey:@"imageName3"]) {
                        BmobFile *file = (BmobFile*)[object objectForKey:@"imageName3"];
                        model.imageName3 = file.url;
                    }
                    info.statesesModel = model;
                    [self.statusFrame replaceObjectAtIndex:indexPath.row withObject:info];
                    [self.tableView reloadData];
                }
            }
        }];
    }];
}

/** 点击坑 */
- (void)kengBtnClick:(NSNotification *)note{
    // toView用nil值，代表UIWindow
    ZDShareButton *btn = note.object;
    NSInteger num = [btn.shuzi integerValue] ;
    NSIndexPath *indexPath =  btn.indexPath;
    num +=1;
    NSString *str = [NSString stringWithFormat:@"%d",num];
    [ZDShareTool updateKengWithObjectID:btn.objID keng:str];
    CGRect convertRect = [btn convertRect:btn.bounds toView:self.tableView];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_sub1"]];
    CGFloat imageX = convertRect.origin.x+20;
    CGFloat imageY = convertRect.origin.y-10;
    CGFloat imageW = 25;
    CGFloat imageH = 25;
    imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    [self.view addSubview:imageView];
    [UIView animateWithDuration:0.6f animations:^{
        imageView.alpha = 0.5;
        imageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        
        NSString *objID = btn.objID;
        ZDShareFrame *info  = [[ZDShareFrame alloc] init];
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"ios_statusese"];
        //查找ios_statusese表里面id为objID的数据
        [bquery getObjectInBackgroundWithId:objID block:^(BmobObject *object,NSError *error){
            if (error){
                //进行错误处理
            }else{
                //表里有id为objID的数据
                if (object) {
                    ZDShareModel *model = [[ZDShareModel alloc] init];
#pragma mark  从服务器中获取最新的行数据更新
                    model.objID = object.objectId;
                    if ([object objectForKey:@"title"]) {
                        model.title = [object objectForKey:@"title"];
                    }
                    if ([object objectForKey:@"icon"]) {
                        model.icon = [object objectForKey:@"icon"];
                    }
                    if ([object objectForKey:@"answer"]) {
                        model.answer  = [object objectForKey:@"answer"];
                    }
                    if ([object objectForKey:@"city"]) {
                        model.city = [object objectForKey:@"city"];
                    }
                    if ([object objectForKey:@"man"]) {
                        model.man = [[object objectForKey:@"man"] boolValue];
                    }
                    if ([object objectForKey:@"zan"]) {
                        model.shuang = [object objectForKey:@"zan"];
                    }
                    if ([object objectForKey:@"keng"]) {
                        model.keng = [object objectForKey:@"keng"];
                    }
                    if ([object objectForKey:@"ping"]) {
                        model.ping = [object objectForKey:@"ping"];
                    }
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
                    model.fbTime = [formatter stringFromDate:object.createdAt];
                    model.createTime =[formatter stringFromDate:object.createdAt];
                    
                    if ([object objectForKey:@"imageName"]) {
                        BmobFile *file = (BmobFile*)[object objectForKey:@"imageName"];
                        model.imageName = file.url;
                    }
                    if ([object objectForKey:@"imageName2"]) {
                        BmobFile *file = (BmobFile*)[object objectForKey:@"imageName2"];
                        model.imageName2 = file.url;
                    }
                    if ([object objectForKey:@"imageName3"]) {
                        BmobFile *file = (BmobFile*)[object objectForKey:@"imageName3"];
                        model.imageName3 = file.url;
                    }
                    info.statesesModel = model;
                    [self.statusFrame replaceObjectAtIndex:indexPath.row withObject:info];
                    [self.tableView reloadData];
                }
            }
        }];
    }];
}

- (void)pingBtnClick:(NSNotification *)note{}
/** 检测当前网络 0没网  1移动3G  2wifi */
- (void)netWork{
    Reachability *reacha = [[Reachability alloc]init];
    NSInteger inter = reacha.currentNetwork;
    if (inter == 0) {
        [self showNetMessage:@"网络不给力.."];
    }else if (inter == 1){
//        [self showNetMessage:@"当前为3G网络"];
    }else if (inter == 2){
//        [self showNetMessage:@"当前Wi-Fi已连接"];
    }
}
- (void)showNetMessage:(NSString *)message{
    [MBProgressHUD showError:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}
@end