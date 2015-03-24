//
//  ZDHomeBarButton.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-23.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDHomeBarButton.h"

@implementation ZDHomeBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置imageView为居中显示
        self.imageView.contentMode = UIViewContentModeLeft;
        // 设置titleLabel的文本队列样式为居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置普通状态下的文字为黑色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置选中状态下的文字为菊花色
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        // 设置标题文本字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
/** 重写image的Rect方法设置图片的显示区域 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.width, self.height);
}
/** 重写title的Rect方法设置文本的显示区域 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.height*0.6, self.width, self.height*0.4);
}


@end
