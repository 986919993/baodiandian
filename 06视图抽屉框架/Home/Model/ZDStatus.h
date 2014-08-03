//
//  ZDStatus.h
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZDUser;
@interface ZDStatus : NSObject

/** 字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;
/** 微博信息内容 */
@property (nonatomic, copy) NSString *text;
/** 微博创建时间 */
@property (nonatomic, copy) NSString *created_at;
/** 微博来源 */
@property (nonatomic, copy) NSString *source;

/** 转发数 */
@property (nonatomic, assign) int reposts_count;
/** 评论数 */
@property (nonatomic, assign) int comments_count;
/** 表态数(赞) */
@property (nonatomic, assign) int attitudes_count;
/** 微博作者的用户信息字段*/
@property (nonatomic, strong) ZDUser *user;
/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;

@end
