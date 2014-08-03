//
//  ZDCommonGroup.h
//  新浪微博
//
//  Created by Dong on 14-7-17.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDCommonItem.h"

@interface ZDCommonGroup : NSObject

/**
 * 头部标题
 */
@property(copy,nonatomic)NSString * header;
/**
 * 底部标题
 */
@property(copy,nonatomic)NSString * footer;
/**
 * 该组所有行的模型数据
 */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;

@end
