//
//  NSString+Extend.h
//  重写QQ聊天2
//
//  Created by Dong on 14-6-8.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

/**
 *  计算文字尺寸
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithfont:(UIFont *)font maxSize:(CGSize)maxSize;
/** 计算文字尺寸 */
- (CGSize)sizeWithfont:(UIFont *)font;
@end
