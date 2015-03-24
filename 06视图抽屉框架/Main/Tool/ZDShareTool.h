//
//  ZDShareTool.h
//  IOSBaoDian
//
//  Created by Dong on 14-8-13.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDShareTool : NSObject
+ (void)updateZanWithObjectID:(NSString *)objID zan:(NSString *)zan;
+ (void)updateKengWithObjectID:(NSString *)objID keng:(NSString *)keng;
@end
