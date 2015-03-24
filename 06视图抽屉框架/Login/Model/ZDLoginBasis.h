//
//  ZDLoginBasis.h
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-7.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDLoginBasis : NSObject
/**
 *  昵称
 */
@property (nonatomic ,copy) NSString *nickname;

/**
 *  性别
 */
@property (nonatomic ,copy) NSString *sex;

/**
 *  所在城市
 */
@property (nonatomic ,copy) NSString *city;

/**
 *  生日
 */
@property (nonatomic ,copy) NSString *birthday;

@end
