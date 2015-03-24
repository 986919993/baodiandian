//
//  IWComposeToolbar.h
//  传智微博
//
//  Created by 李南江 on 14-7-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDPostToolbar;

typedef enum {
    IWComposeToolbarButtonTypeCamera = 0, // 0
    IWComposeToolbarButtonTypePicture,
    IWComposeToolbarButtonTypeMention,
    IWComposeToolbarButtonTypeTrend,
    IWComposeToolbarButtonTypeEmotion
} IWComposeToolbarButtonType;


@protocol IWComposeToolbarDelegate <NSObject>
@optional
//- (void)composeToolbar:(IWComposeToolbar *)toolbar didClickBtn:(UIButton *)button;
- (void)composeToolbar:(ZDPostToolbar *)toolbar didClickBtn:(IWComposeToolbarButtonType)buttonType;
@end


@interface ZDPostToolbar : UIView

@property (nonatomic ,strong) id<IWComposeToolbarDelegate> delegate;
@end
