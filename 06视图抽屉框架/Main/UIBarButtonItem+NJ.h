//
//  UIBarButtonItem+NJ.h
//  传智微博
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NJ)
/**
 *  创建图片按钮
 *
 *  @param image            图片按钮默认状态的图片
 *  @param highlightedImage 图片按钮高亮状态的图片
 *  @param action           监听图片按钮点击时间
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;
@end
