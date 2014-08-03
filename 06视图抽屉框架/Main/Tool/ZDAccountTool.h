//
//  ZDAccountTool.h
//  06视图抽屉框架
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZDAccount;
@interface ZDAccountTool : NSObject
/**
 *  存储一个数据
 *
 *  @param account 需要存储的对象
 *
 *  @return 是否存储成功
 */
+ (BOOL)saveAccount:(ZDAccount *)account;

/**
 *  获取一个存储账号的对象
 */
+ (ZDAccount *)account;

/** 退出当前账号 */
+ (BOOL)removeAccount;
@end
