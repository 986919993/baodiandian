//
//  IWTextView.h
//  传智微博
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDTextView : UITextView
/**
 *  设置提示文字
 */
@property(copy,nonatomic)NSString * placeholder;

@property (nonatomic, strong) UIColor *placeholderColor;

@end
