//
//  ZDLoginInfoModel.h
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-5.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZDLoginIcon;
@class ZDLoginSign;
@class ZDLoginBasis;

@interface ZDLoginInfoModel : NSObject


@property (nonatomic ,strong)ZDLoginIcon  *loginIcon;

@property (nonatomic ,strong)ZDLoginSign *loginSign;

@property (nonatomic ,strong)ZDLoginBasis *lognBasis;


+ (instancetype)infoWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)infoData;

@end
