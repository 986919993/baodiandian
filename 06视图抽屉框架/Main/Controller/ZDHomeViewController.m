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
#import "ZDSpecialViewController.h"
#import "ZDShareViewController.h"
#import "UIView+Add.h"
#import "UIView+NJ.h"

#define kMaxOffset 160
#define kYOffset 80             // Y轴最大调整量
#define kRightXOffset 140       // 向右移动的最大X偏移量
#define kLeftXOffset -190       // 向左移动的最大Y偏移量

@interface ZDHomeViewController () <UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic,assign) CGAffineTransform trans;

@property (nonatomic, assign) UITouch *touch;
/**
 *  发帖按钮
 */
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UIButton *homeButton;
@property (nonatomic, strong) ZDFindViewController *findView;

@property (nonatomic,assign) BOOL settingEdge;
@property (nonatomic,assign) BOOL isIdentity;

@property (nonatomic,copy) NSString *classNames;
@end
@implementation ZDHomeViewController



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
    
    // 实例化要加载的视图控制器
    NSString *className = menuDict[@"className"];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    self.title = menuDict[@"title"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem  alloc]initWithCustomView:self.homeButton];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    if ([vc isKindOfClass:[ZDFindViewController class]]) {
        _findView = (ZDFindViewController *)vc;
        self.navigationItem.titleView = nil;
        self.navigationItem.rightBarButtonItem = nil;
//        self.navigationController.navigationBar.hidden = YES;
        self.classNames = className;
    }else if([vc isKindOfClass:[ZDShareViewController class]]){
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.postButton];
        self.navigationItem.titleView = nil;
        self.classNames = nil;
    }
    else if([vc isKindOfClass:[ZDMoreViewController class]]){
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.titleView = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.classNames = nil;
    }else{
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.titleView = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.classNames = nil;
    }
    [self restoreLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self settingDefault];
    [self settingPanGestureRecognizer];
}

- (void)settingDefault{
    self.trans = ZDTrans;
    [self.tableView removeFromSuperview];
    self.menuDict = @{@"className": @"ZDInfoViewController",@"title":@"资讯"};
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.multipleTouchEnabled= NO;

}

- (void)settingPanGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pangesturerecognizer:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (iOS7 && !self.settingEdge) {
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
        _settingEdge = YES;
    }
//    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
//    
//    pan.delegate = (id<</span>UIGestureRecognizerDelegate>)self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
//        return YES;
//    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    _touch = touch;
    UITextField *textField =  [UIView findFistResponder:self.view];
    [textField resignFirstResponder];
    return YES;
}


- (void)pangesturerecognizer:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        CGPoint location =  CGPointMake(0, 0);
        CGPoint preLocaiton = CGPointMake(0, 0);
        if (_touch != nil) {
            location = [self.touch locationInView:self.view];
            preLocaiton = [self.touch previousLocationInView:self.view];
        }
        if ([pan.view isKindOfClass:[UITableView class]]) {
            if (preLocaiton.y < location.y) {
                [self gestureRecognizer:nil shouldRecognizeSimultaneouslyWithGestureRecognizer:pan];
            }
        }
    }else if (pan.state == UIGestureRecognizerStateChanged){
        CGPoint location =  CGPointMake(0, 0);
        CGPoint preLocaiton = CGPointMake(0, 0);
        if (_touch != nil) {
            location = [self.touch locationInView:self.view];
            preLocaiton = [self.touch previousLocationInView:self.view];
        }
        // 仅计算水平偏移量
        CGPoint offset = CGPointMake(location.x - preLocaiton.x, 0);
        self.navigationController.view.transform = CGAffineTransformTranslate(self.navigationController.view.transform, offset.x, 0);
        CGFloat scale = [self scaleWithX:offset.x];
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

- (void)post
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"post" object:nil];
}


#pragma mark 懒加载

- (UIButton *)postButton{
    if (!_postButton) {
        _postButton = [[UIButton alloc] init];
        _postButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_postButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_pingjia2"] forState:UIControlStateNormal];
        [_postButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_pingjia1"] forState:UIControlStateHighlighted];
        _postButton.frame = CGRectMake(0, 0, 36, 36);
        [_postButton addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postButton;
}
- (UIButton *)homeButton{
    if (!_homeButton) {
        _homeButton = [[UIButton alloc] init];
        _homeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_homeButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_geren2"] forState:UIControlStateNormal];
        [_homeButton setBackgroundImage:[UIImage imageWithNamed:@"leftmenu_geren1"] forState:UIControlStateHighlighted];
        //        [_postButton setTitle:@"发帖" forState:UIControlStateNormal];
        _homeButton.frame = CGRectMake(0, 0, 36, 36);
        [_homeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homeButton;
}


@end
