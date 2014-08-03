//
//  ZDStatus.m
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDStatus.h"
#import "MJExtension.h"
#import "NSDate+NJ.h"
#import "ZDPhoto.h"

@implementation ZDStatus

/** 告诉框架哪个数组里存放什么类  系统会自动调用*/
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[ZDPhoto class]};
}

/**
 *  重写来源get方法
 *
 *  @return 计算位置截取字符串中如:新浪微博  字符串
 */
- (NSString *)source
{
    //  <a href="http://weibo.com" rel="nofollow">新浪微博</a>
    long loc = [_source rangeOfString:@">"].location + 1;
    long len = [_source rangeOfString:@"</"].location - loc;
    NSString *result = [_source substringWithRange:NSMakeRange(loc, len)];
    return [@"来自:" stringByAppendingString:result];
}

/**
 *  重写创建时间get方法
 *
 *  @return 返回一个计算好与当前时间差距的字符串
 */
- (NSString *)created_at
{
    // 判断新浪返回给我们的时间和本地的时间, 返回对应的字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdTime = [formatter dateFromString:_created_at];
    
    // 获取新浪时间和本地时间的差距
    NSDateComponents *cmps = [createdTime deltaWithNow];
    
    if ([createdTime isThisYear]) {
        // 今年
        if ([createdTime isToday]) {
            // 今天
            if (cmps.hour >= 1) {
                // 多少小时以前
                return [NSString stringWithFormat:@"%d小时以前", cmps.hour];
            }else if (cmps.minute >=1)
            {
                // 多少分钟以前  1~60
                return [NSString stringWithFormat:@"%d分钟以前", cmps.minute];
            }else
            {
                return @"刚刚";
            }
            
        }else if ([createdTime isYesterday])
        {
            // 昨天
            formatter.dateFormat = @"昨天: mm分ss";
            return [formatter stringFromDate:createdTime];
        }else
        {
            // 其它天
            formatter.dateFormat = @"MM月dd日 mm分ss";
            return [formatter stringFromDate:createdTime];
        }
    }else
    {
        // 非今年
        formatter.dateFormat = @"yyyy年MM月dd日 mm分ss";
        return [formatter stringFromDate:createdTime];
    }

}
@end
