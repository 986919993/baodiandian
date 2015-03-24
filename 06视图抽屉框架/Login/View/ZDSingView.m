//
//  ZDSingView.m
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDSingView.h"

#define TextFont [UIFont systemFontOfSize:14]

@interface ZDSingView ()<UITextViewDelegate,UIAlertViewDelegate>
@property (nonatomic ,strong)  UITextView *textView;

@property (nonatomic ,assign) BOOL edit;
@end

@implementation ZDSingView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self.view addSubview:self.textView];
    self.textView.text = @"输入签名...";
    ZDLog(@"%@",self.textView);
    self.textView.backgroundColor = [UIColor greenColor];
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
}

#pragma mark UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    if (range.location >= 250) {
        
        return NO;
    }else{
        
        if ([text isEqualToString:@"\n"]) {
            
            
//            [textView resignFirstResponder];
            [self alter];
            
//            return NO;
        }
        
        return YES;
    }
}

- (BOOL)alter
{
    UIAlertView *contentAler = [[ UIAlertView alloc]initWithTitle:@"是否提交签名" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" , nil];
    [contentAler show];
    
    return self.edit;
    
//    if () {
//        ZDLog(@"确定");
//        [self.textView resignFirstResponder];
//        return NO;
//    }else{
//        ZDLog(@"取消");
//        
//    return YES;
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.textView resignFirstResponder];
        self.edit = NO;
    }else{
        self.edit = YES;
        
    }
}



//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"输入签名..."]) textView.text = nil;
  
        
}



//完成编辑
- (void)textViewDidEndEditing:(UITextView *)textView
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    ZDLog(@"textView----- %@",textView.text);
    //设置代理传递输入文本
    if ([self.delegate respondsToSelector:@selector(signView:DoneWithText:)]) {
        [self.delegate signView:self DoneWithText:textView.text];
    }
    
//    return YES;
    
}






#pragma mark - 懒加载
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, self.view.frame.size.height * 0.5)];
//        设置边框
        [_textView.layer setBorderWidth:1];
        [_textView.layer setMasksToBounds:YES];
//        设置内边距
        [_textView setTextContainerInset:UIEdgeInsetsMake(5, 0, 5, 5)];
//        设置字体
        [_textView setFont:TextFont];
        
      
        _textView.userInteractionEnabled = YES;
//        _textView.text = @"输入状态...";
        _textView.textColor = [UIColor lightGrayColor];
    }
    return _textView;
}


@end
