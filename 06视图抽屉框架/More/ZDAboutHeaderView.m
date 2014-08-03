//
//  ILAboutHeaderView.m
//  01-ItcastLottery
//
//  Created by mj on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ZDAboutHeaderView.h"

@implementation ZDAboutHeaderView

+ (instancetype)aboutHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ZDAboutHeaderView" owner:nil options:nil][0];
}
@end
