//
//  UIView+Add.h
//  动画和事件综合例子-键盘处理
//
//  Created by mj on 13-4-16.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Add)
/** 递归找出第一响应者 */
+ (UITextField *)findFistResponder:(UIView *)view;
@end
