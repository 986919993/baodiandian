//
//  ZDHomeViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDHomeViewController.h"
//#import "ZDMenuViewController.h"
#define kMaxOffset 160
#define kYOffset 80             // Y轴最大调整量
#define kRightXOffset 140       // 向右移动的最大X偏移量
#define kLeftXOffset -180       // 向左移动的最大Y偏移量

@interface ZDHomeViewController ()


@end

@implementation ZDHomeViewController

- (void)setMenuDict:(NSDictionary *)menuDict
{
    _menuDict = menuDict;
    
//    NSLog(@"%@", _menuDict);
    // 将之前的子视图控制器删除
    for (UIViewController *controller in self.childViewControllers) {
        // 将子视图控制器的视图从父视图中删除
        [controller.view removeFromSuperview];
        
        // 将视图控制器从父视图控制器中删除
        [controller removeFromParentViewController];
    }
    
    // 加载对应的视图控制器(多态的应用)
    // 1> 实例化要加载的视图控制器
    NSString *className = menuDict[@"className"];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.title = menuDict[@"title"];
    
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
//    vc.navigationItem.leftBarButtonItem.title = @"返回";

    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    
    [self restoreLocation];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"ViewDidLoad");
    self.view.backgroundColor = [UIColor yellowColor];
    self.menuDict = @{@"className": @"NewsNewsViewController",@"title":@"资讯"};
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
    NSLog(@"%f", scale);
    return scale;
}

/** 手指移动计算视图变化位置以及比例 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    CGPoint preLocaiton = [touch previousLocationInView:self.view];
    
    // 仅计算水平偏移量
    CGPoint offset = CGPointMake(location.x - preLocaiton.x, 0);
    
    self.navigationController.view.transform = CGAffineTransformTranslate(self.navigationController.view.transform, offset.x, 0);
    CGFloat scale = [self scaleWithX:offset.x];
//    NSLog(@"scale == %f" ,offset.x);
    if (offset.x <=  self.view.frame.size.width/2) {
        self.navigationController.view.transform = CGAffineTransformScale(self.navigationController.view.transform, scale, scale);
    }
}

/** 手指抬起，根据视图的x值判断视图的目标位置 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
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
        } else {
            self.navigationController.view.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)restoreLocation
{
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.view.transform = CGAffineTransformIdentity;
    }];
}


@end
