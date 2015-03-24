//
//  DJBConsultModel.h
//  DJB项目
//
//  Created by huan on 14-7-23.
//  Copyright (c) 2014年 huan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

#import <BmobSDK/BmobObject.h>//"BmobObject.h"
#import <BmobSDK/BmobQuery.h>//"BmobQuery.h"
#import <BmobSDK/BmobFile.h>

@interface ZDShareModel : NSObject
/**
 *  头像
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  发帖正文
 */
@property (nonatomic, copy) NSString *answer;
/**
 *  发帖人名字
 */
@property (nonatomic, copy) NSString *title;
/**
 *  发帖时间
 */
@property (nonatomic, copy) NSString *fbTime;
/**
 *  阅读次数
 */
@property (nonatomic, copy) NSString *readerCount;
/**
 *  图片1
 */
@property (nonatomic, copy) NSString *imageName;
/**
 *  图片2
 */
@property (nonatomic, copy) NSString *imageName2;
/**
 *  图片3
 */
@property (nonatomic, copy) NSString *imageName3;
/**
 *  性别
 */
@property (nonatomic, assign, getter = isMan) BOOL man;
/**
 *  城市
 */
@property (nonatomic, copy) NSString *city;
/**
 *  爽
 */
@property (nonatomic, copy) NSString *shuang;
/**
 *  坑
 */
@property (nonatomic, copy) NSString *keng;
/**
 *  评论
 */
@property (nonatomic, copy) NSString *ping;
/**
 *  id
 */
@property (nonatomic, copy) NSString *objID;
/**
 *  创建
 */
@property (nonatomic, copy) NSString *createTime;


//- (instancetype)initWithDict:(NSDictionary *)dict;
//+ (instancetype)consultModelWithDict:(NSDictionary *)dict;
//
//+ (NSArray *)consultModel;

@end
