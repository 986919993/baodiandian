//
//  ZDFootHeardCell.m
//  兄弟连
//
//  Created by Dong on 14-7-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDFootCell.h"

@implementation ZDFootCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@synthesize infoModel = _infoModel;
- (void)setInfoModel:(ZDInfoModel *)infoModel
{
    _infoModel = infoModel;
    self.infoModel.detailCellH = 100;
}

@end
