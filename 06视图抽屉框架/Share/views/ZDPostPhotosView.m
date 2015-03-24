//
//  IWComposePhotosView.m
//  传智微博
//
//  Created by apple on 14-7-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDPostPhotosView.h"

@interface ZDPostPhotosView ()



@end

@implementation ZDPostPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (void)setupButton{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage resizableImageNamed:@"jiajiajia"] forState:UIControlStateNormal];
//    UIViewContentModeScaleToFill,
//    UIViewContentModeScaleAspectFit,
//    UIViewContentModeScaleAspectFill,
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.frame = CGRectMake(5, 0, 85, 85);
//    button.size = CGSizeMake(100, 100);
    [self addSubview:button];
    self.button = button;
}

- (void)addImage:(UIImage *)image
{
    // 1.创建uiimageview
    UIImageView *iv1 = [[UIImageView alloc] init];
    // 2.设置数据
    iv1.image = image;
    // 3.添加uiimageview到当前视图
    [self addSubview:iv1];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.button.frame = CGRectMake(5, 5, 50, 50);
    
    int count = self.subviews.count;
    for (int i = 0; i < count; i ++) {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[UIImageView class]]) {
            view.width = self.width / 3 -10;
            view.height = view.width-10;
            view.y = 0;
            view.x = (i - 1) * view.width + (i * 10);
            self.button.x = CGRectGetMaxX(view.frame) +10;
        }
    }
}

- (NSArray *)images
{
    // 1.创建数组保证所有的图片
    NSMutableArray *imagesArray = [NSMutableArray array];
    for (UIImageView *iv in self.subviews) {
        UIImage *image = iv.image;
        [imagesArray addObject:image];
    }
    return imagesArray;
}
@end
