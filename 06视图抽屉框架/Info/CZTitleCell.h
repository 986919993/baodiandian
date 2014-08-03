//
//  CZTitleCell.h
//  05-网易新闻
//
//  Created by LNJ on 14-7-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZBaseCell.h"
typedef enum{
    CZTitleCellSelectedNavTypeIphone = 0,/** 手机资讯 */
    CZTitleCellSelectedNavTypeScience /** 科技资讯 */
}CZTitleCellSelectedNavType;

@protocol CZTitleCellDelegate <NSObject>
@optional
- (void)titleCellDidSelect:(CZTitleCellSelectedNavType)navType;

@end

@interface CZTitleCell : CZBaseCell

@property (nonatomic,weak) id<CZTitleCellDelegate> delegate;

@end
