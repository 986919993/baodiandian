//
//  NSString+Extend.m
//  重写QQ聊天2
//
//  Created by Dong on 14-6-8.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)


/**
 *  计算文字尺寸
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithfont:(UIFont *)font maxSize:(CGSize)maxSize
{
    // 接受文字字体转化为字典类型
    NSDictionary *attrs = @{NSFontAttributeName : font};
    // 利用IOS7之后提供的最新方法计算字符串所占Size 并返回
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(CGSize)sizeWithfont:(UIFont *)font{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self sizeWithAttributes:attrs];
}

@end
