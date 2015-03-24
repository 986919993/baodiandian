//
//  CZDatePickerView.m
//  01-网易彩票
//
//  Created by LNJ on 14-6-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZDatePickerView.h"

@interface CZDatePickerView()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation CZDatePickerView

+ (instancetype)datePickerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CZDatePickerView" owner:nil options:nil] lastObject];
}

// 完成
- (IBAction)done:(id)sender
{
    // 取出日期的数值
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
    // 取出日期字符串
    NSString *dateStr = [formatter stringFromDate:self.datePicker.date];
    
    NSLog(@"%@", dateStr);
    
    SEL func = @selector(datePickerView:dateStr:);
    // 判断代理是否实现方法
    if ([self.delegate respondsToSelector:func]) {
        [self.delegate datePickerView:self dateStr:dateStr];
    }
}

@end
