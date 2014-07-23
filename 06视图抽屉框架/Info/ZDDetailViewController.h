//
//  ZDDetailViewController.h
//  兄弟连
//
//  Created by Dong on 14-7-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDInfoModel.h"

@interface ZDDetailViewController : UITableViewController

/** 从主界面传过来的数据，显示到当前界面 */
@property (nonatomic,strong) ZDInfoModel *infoModel;

@end
