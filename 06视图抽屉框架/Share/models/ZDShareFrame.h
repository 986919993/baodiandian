//
//  DJBShareFrame.h
//  06视图抽屉框架
//
//  Created by huan on 14-8-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZDShareModel;

@interface ZDShareFrame : NSObject

@property (nonatomic, strong) ZDShareModel *statesesModel;

/**
 *  头部视图
 */
@property (nonatomic, assign, readonly) CGRect topViewF;
/**
 *  分享正文
 */
@property (nonatomic, assign, readonly) CGRect contextLabelF;
/**
 *  分享图片
 */
@property (nonatomic, assign, readonly) CGRect shareImageF;
/**
 *  分享图片
 */
@property (nonatomic, assign, readonly) CGRect shareImage2F;
/**
 *  分享图片
 */
@property (nonatomic, assign, readonly) CGRect shareImage3F;
/**
 *  底部视图
 */
@property (nonatomic, assign, readonly) CGRect bottomViewF;
/**
 *  背景
 */
@property (nonatomic, assign, readonly) CGRect bgViewF;
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
