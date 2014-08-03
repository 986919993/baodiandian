//
//  ZDCommonCheckItem.h
//  新浪微博
//
//  Created by Dong on 14-7-17.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDCommonItem.h"

@interface ZDCommonCheckItem : ZDCommonItem

/**
 * 记录是否选中
 */
@property(nonatomic,assign, getter = isChecked) BOOL checked;

@end
