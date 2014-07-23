//
//  ZDDetailCell.m
//  兄弟连
//
//  Created by Dong on 14-7-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDDetailCell.h"
#import "NSString+Path.h"

@interface ZDDetailCell()

/** 详细内容 */
@property (nonatomic,strong) UILabel *detaiLabel;

@end
@implementation ZDDetailCell

@synthesize infoModel = _infoModel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *detaiLabel = [[UILabel alloc]init];
        detaiLabel.textAlignment = NSTextAlignmentLeft;
        _detaiLabel = detaiLabel;
        [self.contentView addSubview:detaiLabel];
    }
    return self;
}

- (void)setInfoModel:(ZDInfoModel *)infoModel
{
    _infoModel = infoModel;
    self.detaiLabel.text = infoModel.detail;
    self.detaiLabel.font = [UIFont systemFontOfSize:15];
    self.detaiLabel.numberOfLines = 0;
    CGRect rect = self.detaiLabel.frame;
    rect.origin = CGPointMake(10, 10);
     rect.size = [self.detaiLabel.text sizeWithFont:self.detaiLabel.font maxSize:CGSizeMake(300, MAXFLOAT)];
    self.detaiLabel.frame = rect;
}





@end
