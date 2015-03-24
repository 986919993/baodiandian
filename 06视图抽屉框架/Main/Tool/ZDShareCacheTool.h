//
//  IWCacheStatusTool.h
//  IOS面试宝典
//
//  Created by apple on 14-7-19.
//  Copyright (c) 2014年 itcast. All rights reserved.


#import <Foundation/Foundation.h>

@interface ZDShareCacheTool : NSObject

/**
 *  返回缓存数据
 *
 *  @param param 请求参数
 *
 *  @return 微博数据
 */
+ (NSArray *)newsStatusWith:(NSString *)date index:(NSInteger)index;

// 2.存储分享信息
+ (void)saveStatus:(NSDictionary *)json date:(NSString *)date;
// 更多
+ (NSArray *)moreStatusWith:(NSString *)date index:(NSInteger)index;

@end
