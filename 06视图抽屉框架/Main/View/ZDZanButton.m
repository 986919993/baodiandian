//
//  ZDZanButton.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-26.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDZanButton.h"

@implementation ZDZanButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageWithNamed:@"zan"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageWithNamed:@"zan"] forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeRedraw;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.textColor= [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = self.frame.size.width * 0.5;
    CGFloat imageY = self.frame.size.width * 0.5-4;
    CGFloat imageW = self.frame.size.width * 0.4;
    CGFloat imageH = 23;
    return  CGRectMake(imageX, imageY, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 3;
    CGFloat titleY = 2;
    CGFloat titleW = self.frame.size.width * 0.6;
    CGFloat titleH = self.frame.size.height;
    return  CGRectMake(titleX , titleY, titleW, titleH);
}

- (void)setZan:(NSNumber *)zan{
    _zan = zan;
    NSString *title = [NSString stringWithFormat:@"%@",zan];
//    NSLog(@"%@",title);
    [self setTitle:title forState:UIControlStateNormal];
}

@end
