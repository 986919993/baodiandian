//
//  CZNormalCell.m
//  05-网易新闻
//
//  Created by LNJ on 14-7-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZNormalCell.h"
#import "UIImageView+WebCache.h"

@interface CZNormalCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *digest;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@end

@implementation CZNormalCell
// @synthesize 合成指令转本用于指定属性对应的成员变量
// 子类的dict属性，使用的成员变量名称是_dict
@synthesize dict = _dict;

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    // 设置表格内容
    [self.icon sd_setImageWithURL:dict[ZDImgSrcKey]];
    self.title.text = dict[ZDTitleKey];
    self.digest.text = dict[ZDDigestKey];
    self.replyCount.text = [NSString stringWithFormat:@"阅读数:%@", dict[ZDReplyCountKey]];
}

+ (CGFloat)rowHeight
{
    return 80;
}

@end
