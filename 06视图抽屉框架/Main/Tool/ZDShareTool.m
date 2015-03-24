//
//  ZDShareTool.m
//  IOSBaoDian
//
//  Created by Dong on 14-8-13.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDShareTool.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobObject.h>//"BmobObject.h"
#import <BmobSDK/BmobQuery.h>//"BmobQuery.h"
#import <BmobSDK/BmobFile.h>

@implementation ZDShareTool

+ (void)updateZanWithObjectID:(NSString *)objID zan:(NSString *)zan{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"ios_statusese"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:objID block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                //设置cheatMode为YES
                [object setObject:zan forKey:@"zan"];
                //异步更新数据
                [object updateInBackground];
            }
        }else{
            //进行错误处理
//            NSLog(@"%@",error);
        }
    }];
}

+ (void)updateKengWithObjectID:(NSString *)objID keng:(NSString *)keng{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"ios_statusese"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:objID block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                //设置cheatMode为YES
                [object setObject:keng forKey:@"keng"];
                //异步更新数据
                [object updateInBackground];
            }
        }else{
            //进行错误处理
//            NSLog(@"%@",error);
        }
    }];
};
@end
