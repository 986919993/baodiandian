//
//  DJBSpecialViewController.m
//  06视图抽屉框架
//
//  Created by huan on 14-8-3.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "DJBSpecialViewController.h"

@interface DJBSpecialViewController ()

@property (nonatomic, strong) UIImageView *specialImageView;

@end

@implementation DJBSpecialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.specialImageView.image = [UIImage resizableImageNamed:@"bg"];
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
