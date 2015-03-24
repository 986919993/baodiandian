//
//  DJBSpecialViewController.m
//  06视图抽屉框架
//
//  Created by huan on 14-8-3.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDSpecialViewController.h"
#import "ZDHomeViewController.h"
#import "ZDRootViewController.h"

@interface ZDSpecialViewController ()

@property (nonatomic, strong) UIImageView *specialImageView;
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UIButton *homeButton;

@end

@implementation ZDSpecialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.specialImageView.image = [UIImage resizableImageNamed:@"Default-568h"];
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



- (UIImageView *)specialImageView{
    if (!_specialImageView) {
        _specialImageView = [[UIImageView alloc] init];
        _specialImageView.frame = self.view.bounds;
        [self.view addSubview:_specialImageView];
    }
    return _specialImageView;
}

@end
