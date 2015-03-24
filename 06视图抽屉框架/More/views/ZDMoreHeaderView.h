//
//  ZDHeaderView.h
//  06视图抽屉框架
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDMoreHeaderView;
@protocol ZDMoreHeaderViewDelegate <NSObject>

- (void)didClickHeaderView:(BOOL)isAccount;

@end

@interface ZDMoreHeaderView : UIView

+ (instancetype)moreHeaderView;

@property (nonatomic,weak) id<ZDMoreHeaderViewDelegate> headerDelegate;

@end
