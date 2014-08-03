//
//  ZDCommonCell.h
//  新浪微博
//
//  Created by Dong on 14-7-17.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDCommonItem;

@interface ZDCommonCell : UITableViewCell

/**
 *  实例化cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  每一行对应的数据模型
 */
@property (nonatomic,strong) ZDCommonItem *item;
/**
 *  对应的indexPath
 */
@property (nonatomic,strong) NSIndexPath *indexPath;

@end
