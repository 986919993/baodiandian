//
//  UIView+Add.m
//  动画和事件综合例子-键盘处理
//
//  Created by mj on 13-4-16.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)
#pragma mark 递归找出第一响应者
+ (UITextField *)findFistResponder:(UIView *)view {
    for (UIView *child in view.subviews) {
        if ([child respondsToSelector:@selector(isFirstResponder)]
            &&
            [child isFirstResponder]) {
            return (UITextField *)child;
        }
        
        UITextField *field = [self findFistResponder:child];
        if (field) {
            return field;
        }
    }
    
    return nil;
}
@end
