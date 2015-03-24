//
//  ZDLoginSignCell.m
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDLoginSignCell.h"

@interface ZDLoginSignCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *signField;


@end

@implementation ZDLoginSignCell


+(CGFloat)rowHeight
{
    return 50;
}



- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
//            UITapGestureRecognizer *sign = [[UITapGestureRecognizer alloc]initWithTarget:self.signField action:@selector(signTap)];
//            [self.signField addGestureRecognizer:sign];
//        
//        [self.signField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        if (iOS8) {
//            self.signField.userInteractionEnabled = NO;
//        }
    }
    return self;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    ZDLog(@"sign");
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZDLoginSignCell" object:nil];
//    
//}


//- (void)signTap
//{
//    ZDLog(@"signtap");
//}
//
//
// - (void) textFieldDidChange:(UITextField *) TextField{
//     ZDLog(@"sing");
// }
//
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    ZDLog(@"sing");
//}

@end
