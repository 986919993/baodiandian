//
//  DJBShareCell.h
//  06视图抽屉框架
//
//  Created by huan on 14-8-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDShareFrame,ZDShareCell;

@interface ZDShareCell : UITableViewCell

+ (instancetype)cellWithTableview:(UITableView *)tableView;
@property (nonatomic, strong) ZDShareFrame *shareFrame;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
