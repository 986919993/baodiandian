//
//  ZDCommonItem.h
//  新浪微博
//
//  Created by Dong on 14-7-17.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDCommonItem : NSObject

/**
 *  图标
 */
@property (nonatomic,copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  子标题
 */
@property (nonatomic,copy) NSString *subtitle;
/**
 *  提醒数字
 */
@property (nonatomic,copy) NSString *badgeValue;
/**
 *  保存目标控制器
 */
@property (nonatomic,assign) Class destVC;
/**
 *  保存点击cell之后要执行的代码
 */
@property (nonatomic,copy) void (^opertion)();

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

+ (instancetype)itemWithTitle:(NSString *)title;

@end
