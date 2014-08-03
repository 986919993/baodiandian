//
//  ZDHomeViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDHomeViewController.h"
#import "ZDSearchBar.h"
#import "ZDNavViewController.h"
#import "ZDFindViewController.h"
#import "ZDHomeBarButton.h"
#import "ZDMoreViewController.h"
#import "DJBSpecialViewController.h"

#define kMaxOffset 160
#define kYOffset 80             // Y轴最大调整量
#define kRightXOffset 140       // 向右移动的最大X偏移量
#define kLeftXOffset -190       // 向左移动的最大Y偏移量

@interface ZDHomeViewController () <UIGestureRecognizerDelegate>

@property (nonatomic,assign) CGAffineTransform trans;

@property (nonatomic,strong) ZDSearchBar *searchBar;

@property (nonatomic, assign) UITouch *touch;
/**
 *  特效控制器
 */
@property (nonatomic, weak) DJBSpecialViewController *vc;

@property (nonatomic,assign) BOOL settingEdge;
@property (nonatomic,assign) BOOL isIdentity;
@end
@implementation ZDHomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        DJBSpecialViewController *vc = [[DJBSpecialViewController alloc] init];
        vc.view.backgroundColor = [UIColor redColor];
        
        [self.view addSubview:vc.view];
        [self addChildViewController:vc];
        self.vc = vc;
        [self removeChildController];
    }
    return self;
}

- (void)removeChildController{
    [UIView animateWithDuration:5.0 animations:^{
        self.vc.view.alpha = 0;
        self.vc.view.transform = CGAffineTransformMakeScale(5.0, 5.0);
    }completion:^(BOOL finished) {
        [self.vc removeFromParentViewController];
        [self.vc.view removeFromSuperview];
    }];
}

- (void)setMenuDict:(NSDictionary *)menuDict
{
    _menuDict = menuDict;
    // 将之前的子视图控制器删除
    for (UIViewController *controller in self.childViewControllers) {
        // 将子视图控制器的视图从父视图中删除
        [controller.view removeFromSuperview];
        // 将视图控制器从父视图控制器中删除
        [controller removeFromParentViewController];
    }
    // 加载对应的视图控制器(多态的应用)
    // 实例化要加载的视图控制器
    NSString *className = menuDict[@"className"];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    self.title = menuDict[@"title"];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemHomeImage:@"home" highlightedImage:@"home_hlighted" target:self action:@selector(home)];
    if ([vc isKindOfClass:[ZDFindViewController class]]) {
        ZDSearchBar *searchBar = [[ZDSearchBar alloc]init];
        searchBar.frame = CGRectMake(0, 0, 300, 35);
        searchBar.font = [UIFont systemFontOfSize:14];
        searchBar.placeholder = @"请输入搜索内容";
        self.searchBar = searchBar;
        self.navigationItem.titleView = searchBar;
    }else if([vc isKindOfClass:[ZDMoreViewController class]]){
//        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//        [self.navigationController.navigationBar setAlpha:0];
        self.navigationItem.titleView = nil;
    }else{
        self.navigationItem.titleView = nil;
    }
//    vc.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [self restoreLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self settingDefault];
    [self settingPanGestureRecognizer];
//    self.wantsFullScreenLayout = YES;
//    UIViewController的一个属性.
//    wantsFullScreenLayout
}

- (void)settingDefault{
    self.trans = ZDTrans;
    [self.tableView removeFromSuperview];
    self.menuDict = @{@"className": @"ZDInfoViewController",@"title":@"资讯"};
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)settingPanGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pangesturerecognizer:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
}

- (void)dealloc
{
    ZDLog(@"销毁home");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (iOS7 && !self.settingEdge) {
        self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
        _settingEdge = YES;
    }
    self.tableView.multipleTouchEnabled= NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    _touch = touch;
    [self.searchBar resignFirstResponder];
    return YES;
}

- (void)pangesturerecognizer:(UIPanGestureRecognizer *)pan
{

    if (pan.state == UIGestureRecognizerStateBegan) {
        
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        CGPoint location = [_touch locationInView:self.view];
        CGPoint preLocaiton = [_touch previousLocationInView:self.view];
        
        // 仅计算水平偏移量
        CGPoint offset = CGPointMake(location.x - preLocaiton.x, 0);
        
        self.navigationController.view.transform = CGAffineTransformTranslate(self.navigationController.view.transform, offset.x, 0);
        CGFloat scale = [self scaleWithX:offset.x];
//        NSLog(@"scale == %f" ,offset.x);
        if (offset.x <=  self.view.frame.size.width/2) {
            self.navigationController.view.transform = CGAffineTransformScale(self.navigationController.view.transform, scale, scale);
        }

    }else {
        CGRect frame = self.navigationController.view.frame;
        CGSize screen = [UIScreen mainScreen].bounds.size;
        CGFloat x = 0;
        // 判断是否向右移动，如果向右超出屏幕宽度一半
        if (frame.origin.x > screen.width * 0.5) {
            x = kRightXOffset;
        } else if (frame.origin.x < -screen.width * 0.5) {
            x = 0;
        } else {
            x = 0;
        }
        
        CGFloat offsetX = x - frame.origin.x;
        
        [UIView animateWithDuration:0.25 animations:^{
            if (x != 0) {
                self.navigationController.view.transform = CGAffineTransformTranslate(self.navigationController.view.transform, offsetX, 0);
                CGFloat scale = [self scaleWithX:offsetX];
                self.navigationController.view.transform = CGAffineTransformScale(self.navigationController.view.transform, scale, scale);
                self.trans = self.navigationController.view.transform;
                self.isIdentity = YES;
            } else {
                self.navigationController.view.transform = CGAffineTransformIdentity;
                self.isIdentity = NO;
            }
        }];
    
    }
    
}


#pragma mark - 手势拖拽移动视图位置
- (CGRect)calcRectWithX:(CGFloat)x {
    CGSize screen = [UIScreen mainScreen].bounds.size;
    
    // 要变化的y值
    CGFloat y = ABS(x) / screen.width * kYOffset;
    // 根据y值的变化计算缩小比例
    CGFloat scale = (screen.height - 2 * y) / screen.height;
    CGFloat w = screen.width * scale;
    CGFloat h = screen.height * scale;
    
    return CGRectMake(x, y, w, h);
}

- (CGFloat)scaleWithX:(CGFloat)x {
    CGSize screen = [UIScreen mainScreen].bounds.size;
    
    // 要变化的y值
    CGFloat y = x / screen.width * kYOffset;
    // 根据y值的变化计算缩小比例
    CGFloat scale = (screen.height - 2 * y) / screen.height;
    if (self.navigationController.view.frame.origin.x >= 0) {
        return scale;
    } else {
        return 2 - scale;
    }
//    NSLog(@"%f", scale);
    return scale;
}

- (void)restoreLocation
{
    self.isIdentity = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.view.transform = CGAffineTransformIdentity;
    }];
}
- (void)home
{
    if (self.isIdentity) {
        [self restoreLocation];
    }else{
        self.isIdentity = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.view.transform = self.trans;
        }];
    }
}

@end
