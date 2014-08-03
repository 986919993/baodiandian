//
//  ZDUser.m
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDUser.h"

@implementation ZDUser
/** 是否是Vip */
- (BOOL)isVip
{
    // 当mbtype大于等于2表示此用户是会员
    return self.mbtype >= 2;
}

@end
