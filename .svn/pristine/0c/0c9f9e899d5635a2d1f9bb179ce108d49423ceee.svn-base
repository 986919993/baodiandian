//
//  UIBarButtonItem+NJ.m
//  传智微博
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIBarButtonItem+NJ.h"
#import "ZDHomeBarButton.h"

@implementation UIBarButtonItem (NJ)

/**
 *  创建图片按钮
 *
 *  @param image            图片按钮默认状态的图片
 *  @param highlightedImage 图片按钮高亮状态的图片
 *  @param action           监听图片按钮点击时间
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action
{
    // 创建一个UIButton
    UIButton *btn = [[UIButton alloc] init];
    // 设置默认状态图片
    [btn setImage:[UIImage imageWithNamed:image] forState:UIControlStateNormal];
    // 设置高亮状态图片
    [btn setImage:[UIImage imageWithNamed:highlightedImage] forState:UIControlStateHighlighted];
    // 设置size
    btn.size = btn.currentImage.size;
    // 监听点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 用对象方法自定义视图,实例化一个BarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemHomeImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action
{
    // 创建一个UIButton
    ZDHomeBarButton *btn = [[ZDHomeBarButton alloc] init];
    // 设置默认状态图片
    [btn setImage:[UIImage imageWithNamed:image] forState:UIControlStateNormal];
    // 设置高亮状态图片
    [btn setImage:[UIImage imageWithNamed:highlightedImage] forState:UIControlStateHighlighted];
    // 设置size
    btn.size = btn.currentImage.size;
//    btn.contentMode = UIViewContentModeLeft;
    // 监听点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 用对象方法自定义视图,实例化一个BarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
