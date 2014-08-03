//
//  ZDMenuViewController.h
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDMenuViewControllerDelegate <NSObject>

- (void)menuViewControllerDidSelectedDict:(NSDictionary *)dict;

@end

@interface ZDMenuViewController : UITableViewController

/** 设置代理 */
@property (nonatomic,weak) id<ZDMenuViewControllerDelegate> menuDelegate;

@end
