//
//  ZDBaseCell.m
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-5.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDBaseCell.h"
#import "MJExtension.h"
#import "ZDLoginInfoModel.h"

@implementation ZDBaseCell

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        self.userInteractionEnabled = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

+(CGFloat)rowHeight
{
    return 50;
}




@end
