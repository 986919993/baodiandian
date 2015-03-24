//
//  IWTextView.m
//  传智微博
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDTextView.h"

@interface ZDTextView ()<UITextViewDelegate>
/**
 *  提示文本容器
 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation ZDTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.创建label
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = [UIColor grayColor];
        label.font = self.font;
        [self addSubview:label];
        self.label = label;
        
        // 2.监听textView文本的改变
//        self.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    // 取消监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)textChange
{
    // 判断当前文本输入框有没有文字
    if (self.text.length) {
//        有文字 , 隐藏label
        self.label.hidden = YES;
    }else{
//        没有文字 显示label
        self.label.hidden = NO;
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    // 1.设置提示文本
    self.label.text = _placeholder;
    CGSize textMaxSize = CGSizeMake(self.width, MAXFLOAT);
    CGSize textSize = [_placeholder sizeWithFont:self.label.font constrainedToSize:textMaxSize];
    self.label.x = 5;
    self.label.y = 5;
    self.label.size = textSize;
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.label.textColor = placeholderColor;
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.label.font = font;

    // 重新计算label的frame
    CGSize textMaxSize = CGSizeMake(self.width, MAXFLOAT);
    CGSize textSize = [_placeholder sizeWithFont:self.label.font constrainedToSize:textMaxSize];
    self.label.x = 5;
    self.label.y = 5;
    self.label.size = textSize;
    
}



@end
