//
//  CZPhotosCell.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-29.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "CZPhotosCell.h"
#import "UIImageView+WebCache.h"

@interface CZPhotosCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

@end
@implementation CZPhotosCell
@synthesize dict = _dict;

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    // 设置表格内容
    [self.image1 sd_setImageWithURL:dict[@"imgsrc"]];
    [self.image2 sd_setImageWithURL:dict[@"imgextra"][0][@"imgsrc"]];
    [self.image3 sd_setImageWithURL:dict[@"imgextra"][1][@"imgsrc"]];
    
    self.title.text = dict[ZDTitleKey];
    self.replyCount.text = [NSString stringWithFormat:@"阅读数:%@", dict[ZDReplyCountKey]];
}
+ (CGFloat)rowHeight
{
    return 90;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
