//
//  ZDSingView.h
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDSingView;

@protocol ZDSingViewDelegate <NSObject>

- (void)signView:(ZDSingView *)singView DoneWithText:(NSString *)text;

@end

@interface ZDSingView : UIViewController
@property (nonatomic,weak)id<ZDSingViewDelegate>delegate;

@end
