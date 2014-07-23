//
//  ZDInfoModel.m
//  兄弟连
//
//  Created by Dong on 14-7-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDInfoModel.h"

@implementation ZDInfoModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)infoWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

+ (NSMutableArray *)infoModel{
    NSDictionary *infoDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataList.plist" ofType:nil]];
    NSArray *array = infoDict[@"XD18510163661"];
    NSMutableArray *infoArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        ZDInfoModel *infoModel = [ZDInfoModel infoWithDict:dict];
        [infoArray addObject:infoModel];
    }
    return infoArray;
}

- (void)setDetailCellH:(NSInteger)detailCellH
{
    _detailCellH = detailCellH;
}



@end
