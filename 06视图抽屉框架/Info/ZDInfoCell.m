//
//  ZDInfoCell.m
//  兄弟连
//
//  Created by Dong on 14-7-3.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDInfoCell.h"
@interface ZDInfoCell()
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageName;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *issuerDate;
@property (weak, nonatomic) IBOutlet UILabel *issuer;

@end
@implementation ZDInfoCell

-(void)setDict:(ZDInfoModel *)dict
{
    _dict = dict;
    self.imageName.image = [UIImage imageNamed:dict.imageName];
    self.title.text = dict.title;
    self.issuerDate.text = [NSString stringWithFormat:@"发布时间：%@",dict.issuerDate];
    self.issuer.text = [NSString stringWithFormat:@"作者：%@",dict.issuer];
}

@end
