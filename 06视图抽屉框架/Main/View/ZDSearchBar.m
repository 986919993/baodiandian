//
//  ZDSearchBar.m
//  新浪微博
//
//  Created by Dong on 14-7-8.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDSearchBar.h"

@implementation ZDSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景图片
        self.background = [UIImage resizableImageNamed:@"searchbar_textfield_background"];
        // 设置文字对齐样式
        self.textAlignment = NSTextAlignmentLeft;
        // 放大镜图片
        UIImage *image = [UIImage imageWithNamed:@"searchbar_textfield_search_icon"];
        UIImageView *icon = [[UIImageView alloc]initWithImage:image];
        // 图片的宽
        icon.width = 0;
        icon.contentMode = UIViewContentModeLeft;
        // 设置提示文字
        self.placeholder = @"搜索";
        // 设置删除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.leftView = icon;
        self.leftViewMode = UITextFieldViewModeAlways;
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


@end
