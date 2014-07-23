//
//  ZDDetailHeardCell.m
//  兄弟连
//
//  Created by Dong on 14-7-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDDetailHeardCell.h"
@interface ZDDetailHeardCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *issuerDate;
@property (weak, nonatomic) IBOutlet UILabel *issuer;


@end
@implementation ZDDetailHeardCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
@synthesize infoModel = _infoModel;

-(void)setInfoModel:(ZDInfoModel *)infoModel
{
    _infoModel = infoModel;
    self.title.text = infoModel.title;
    self.issuerDate.text = [NSString stringWithFormat:@"发布时间：%@",infoModel.issuerDate];
    self.issuer.text = [NSString stringWithFormat:@"发布者：%@",infoModel.issuer];
    self.infoModel.detailCellH = 80;
}


@end
