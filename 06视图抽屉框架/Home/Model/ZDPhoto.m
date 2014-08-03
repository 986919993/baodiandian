//
//  ZDPhoto.m
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDPhoto.h"

@implementation ZDPhoto

- (NSString *)bmiddle_pic
{
    /*
     http://ww2.sinaimg.cn/thumbnail/5408ee85jw1eib098z32hj20b40aqaan.jpg
     http://ww2.sinaimg.cn/bmiddle/5408ee85jw1eib098z32hj20b40aqaan.jpg
     */
    return [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
