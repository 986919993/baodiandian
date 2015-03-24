//
//  ZDDataTool.h
//  IOSBaoDian
//
//  Created by Dong on 14-8-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDDataTool : NSObject
+ (void)updata:(NSNumber *)dataID  zan:(NSInteger)zan;
+ (NSMutableArray *)dataWithItemType:(NSString *)itemType;
+ (NSMutableArray *)dataWithSearch:(NSString *)text;
+ (NSMutableArray *)dataWithSearch:(NSString *)text ItemType:(NSString *)itemType;
+ (NSMutableArray *)dataList;
@end
