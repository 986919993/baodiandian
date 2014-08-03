//
//  ZDStatusFrame.m
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDStatusFrame.h"
#import "ZDStatusCell.h"
#import "ZDStatus.h"
#import "ZDUser.h"

@implementation ZDStatusFrame

- (void)setStatus:(ZDStatus *)status
{
    // 赋值数据
    _status = status;
    
    // 计算头部Frame
    [self setupTopViewFrame];
    // 计算底部Frame
    [self setupBotViewFrame];
    
    // 7.cell的高度
    _cellHeight = CGRectGetMaxY(_toolbarF);
    
}

/** 计算头部View的Frame */
- (void)setupTopViewFrame
{
    // 设置原创微博Frame
    [self setupOriginalViewFrame];

    // 没有转发微博时的高度
    CGFloat topH = CGRectGetMaxY(_originalViewF);
    CGFloat topX = ZERO;
    CGFloat topY = ZDPadding;
    CGFloat topW = ZDWidth;
    _topViewF = CGRectMake(topX, topY, topW, topH);
}

/** 计算原创微博的Frame */
- (void)setupOriginalViewFrame
{
    // 获取主屏宽度
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    // 1.头像
    CGFloat iconX = ZDPadding;
    CGFloat iconY = ZDPadding;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    _iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + ZDPadding;
    CGFloat nameY = iconY;
    NSString *name = _status.user.name ;
    CGSize nameSize = [name sizeWithFont:ZDNameFont];
    _nameLabelF = (CGRect){{nameX , nameY}, nameSize};
    
    // 3.vip
    CGFloat vipX = CGRectGetMaxX(_nameLabelF) + ZDPadding;
    CGFloat vipY = nameY;
    CGFloat vipW = 14;
    CGFloat vipH = nameSize.height;
    _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    
    // 4.正文
    CGFloat textX = ZDPadding;
    CGFloat textY = CGRectGetMaxY(_iconViewF) + ZDPadding;
    CGFloat textW = width - ZDPadding * 2;
    NSString *text = _status.text;
    CGSize textMaxSize = CGSizeMake(textW, MAXFLOAT);
    // 计算正文文本的宽高
    CGSize textSize =  [text sizeWithFont:ZDContentFont constrainedToSize:textMaxSize];
    _contentLabelF = (CGRect){{textX, textY}, textSize};
    
    // 5.计算配图
    int count = _status.pic_urls.count;
    CGFloat originalH = 0;
    CGFloat photoX = ZDPadding;
    if (count) {
        // 有配图时调用类方法传入一共有多少张图计算配图所占大小
        CGSize photoSize = [self photoViewSizeWithCount:count];

        CGFloat photoY = CGRectGetMaxY(_contentLabelF) + ZDPadding;
        _photoViewF = (CGRect){{photoX,photoY},photoSize};
        originalH = CGRectGetMaxY(_photoViewF) + ZDPadding;
    }else{
        originalH = CGRectGetMaxY(_contentLabelF) + ZDPadding;
    }
    
    // 6.原创微博的Frame
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = width;
    _originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
}

// 传入当条微博有多少张图片  计算每一张图所占大小
- (CGSize)photoViewSizeWithCount:(int)count
{
    CGFloat imageW = 70;
    CGFloat imageH = 70;
    CGFloat imagePadding = 10;
    // 计算列号 >=3时 宽度永远按3走  小于3时按照当前图片数计算宽度
    int col = count >= 3 ? 3 : count;
    // 计算行号
    // 当取模3 == 0 时表示刚好是3的倍数 不需要增加一行
    int row = count / 3;;
    // 不等于0时 表示有额外的图片 需要增加一行
    if (count % 3 != 0)
    {
        row = row + 1;
    }
    //    宽度 = 图片的宽度 * 列数+　（列数　－　1）　＊　间隙
    CGFloat photoW = (imageW * col) + ((col - 1) * imagePadding);
    //    高度 = 图片的高度 * 行数+　（行数　－　1）　＊　间隙
    CGFloat photoH = (imageH * row) + ((row - 1) * imagePadding);
    
    return CGSizeMake(photoW, photoH);
}

// 计算底部View的Frame
- (void)setupBotViewFrame
{
    // 8 bottomView
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(_topViewF) + 1;
    CGFloat toolbarW = ZDWidth;
    CGFloat toolbarH = 35;
    _toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}


@end
