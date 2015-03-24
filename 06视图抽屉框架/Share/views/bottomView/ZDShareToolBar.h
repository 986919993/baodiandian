//
//  DJBBottomVIew.h
//  06视图抽屉框架
//
//  Created by huan on 14-8-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//
typedef enum{
    ZDButtonTypeShuang,
    ZDButtonTypeKeng,
    ZDButtonTypeCommon,
    ZDButtonTypeShare
} ZDButtonType;
@class ZDShareModel;

#import <UIKit/UIKit.h>

@interface ZDShareToolBar : UIView

@property (nonatomic,strong) ZDShareModel *statusModel;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
