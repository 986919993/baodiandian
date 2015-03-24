//
//  ZDFindViewController.h
//  新浪微博
//
//  Created by Dong on 14-7-6.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDCommonCell.h"
#import "ZDCommonGroup.h"
#import "ZDCommonSwitchItem.h"
#import "ZDCommonLabelItem.h"
#import "ZDCommonArrowItem.h"
#import "ZDCommonCheckItem.h"
#import "ZDCommonCheckGroup.h"

@interface ZDCommonViewController : UITableViewController

- (ZDCommonGroup *)addGroup;
- (ZDCommonCheckGroup *)addCheckGroup;
/**
 *  后去对应的组模型
 *
 *  @param section 选中的组
 */
- (ZDCommonCheckGroup *)groupWithSection:(NSInteger)section;
@end
