//
//  ZDUser.h
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDUser : NSObject

/** 字符串型的用户UID */
@property (nonatomic, copy) NSString *idstr;
/** 友好显示名称 */
@property (nonatomic, copy) NSString *name;
/** 用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;
/** 会员的等级 */
@property(nonatomic,assign) int  mbrank;
/** 是否是会员 (注意:新浪返回的数据如果mbtype >= 2就是会员) */
@property(nonatomic,assign) int  mbtype;

- (BOOL)isVip;

/*
 mbrank = 4;  会员的等级
 mbtype = 13; 是否是会员 (注意:新浪返回的数据如果mbtype >= 2就是会员)
 */

@end
