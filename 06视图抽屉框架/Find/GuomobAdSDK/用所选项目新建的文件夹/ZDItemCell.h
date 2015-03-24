//
//  ZDItemCell.h
//  06视图抽屉框架
//
//  Created by Dong on 14-8-1.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDItemCell : UITableViewCell


@property (nonatomic,strong) NSDictionary *dict;

+ (CGFloat)cellHeight;
@end
