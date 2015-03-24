//
//  ZDEditAlter.m
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDEditAlter.h"

@interface ZDEditAlter()


@end

@implementation ZDEditAlter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.alertViewStyle = UIAlertViewStylePlainTextInput;
        self.textField.returnKeyType = UIReturnKeyDone;
 
        // 基本输入框，显示实际输入的内容
        self.alertViewStyle = UIAlertViewStylePlainTextInput;
        // 用户名，密码登录框
        //    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        // 密码形式的输入框，输入字符会显示为圆点
        //    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        
    }
    return self;
}





#pragma mark - 懒加载
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [self textFieldAtIndex:0];
    }
    return _textField;
}

@end
