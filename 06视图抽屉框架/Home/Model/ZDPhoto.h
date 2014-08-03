//
//  ZDPhoto.h
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDPhoto : NSObject

/** 配图的缩略图*/
@property(copy,nonatomic) NSString *thumbnail_pic;

/** 提供给外界一个中等图*/
- (NSString *)bmiddle_pic;


@end
