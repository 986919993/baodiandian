//
//  UIImage+NJ.h
//  传智微博
//
//  Created by apple on 14-7-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NJ)

/**
 *  创建一个已经适配好了iOS67的图片
 *
 *  @param name 图片名称
 */
+ (instancetype)imageWithNamed:(NSString *)name;

/**
 *  创建一个拉伸不变形的图片 默认左0.5 上0.5
 *
 *  @param name 图片名称
 */
+ (instancetype)resizableImageNamed:(NSString *)name;

/**
 *  创建一个拉伸不变形的图片 自定义拉伸范围  左  上
 */
+ (instancetype)resizableImageNamed:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

@end
