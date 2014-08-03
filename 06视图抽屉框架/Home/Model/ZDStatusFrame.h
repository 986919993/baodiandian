//
//  ZDStatusFrame.h
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZDStatus;
@interface ZDStatusFrame : NSObject

/*  数据模型 */
 
@property (nonatomic, strong) ZDStatus *status;
/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 原创微博的view */
@property (nonatomic, assign, readonly) CGRect originalViewF;

/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 原创配图 */
@property (nonatomic, assign, readonly) CGRect photoViewF;


/** 底部的工具条 */
@property (nonatomic, assign, readonly) CGRect toolbarF;
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
