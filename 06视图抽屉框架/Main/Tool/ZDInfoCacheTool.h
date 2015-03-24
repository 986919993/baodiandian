//
//  ZDInfoCacheTool.h
//  IOSBaoDian
//
//  Created by Dong on 14-8-16.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDInfoCacheTool : NSObject
/**
 *  返回缓存数据
 *
 *  @param param 请求参数
 *
 *  @return 微博数据
 */
+ (NSDictionary *)newsStatusWith:(NSString *)date index:(NSInteger)index;
// 2.存储新闻信息
+ (void)saveStatus:(NSDictionary *)json date:(NSString *)date;
@end
