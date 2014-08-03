//
//  ZDStatusCell.h
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDStatusFrame;
@interface ZDStatusCell : UITableViewCell

/** statusFrame模型数据 */
@property (nonatomic,strong) ZDStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
