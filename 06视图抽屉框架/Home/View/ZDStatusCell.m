//
//  ZDStatusCell.m
//  新浪微博
//
//  Created by Dong on 14-7-10.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDStatusCell.h"
#import "ZDStatus.h"
#import "ZDStatusFrame.h"
#import "ZDUser.h"
//#import "UIImageView+WebCache.h"
#import "ZDTopView.h"
#import "ZDBotView.h"

@interface ZDStatusCell()
/** 顶部的view */
@property (nonatomic, weak) ZDTopView *topView;
/** 底部的工具条 */
@property (nonatomic, weak) ZDBotView *botView;

@end



@implementation ZDStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 定义一个可重用标示符
    static NSString *ID = @"cell";
    // 去缓存池中取出对应标示符可重用的cell
    ZDStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZDStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupTopView];
        [self setupBotView];
    }
    return self;
}

- (void)setupTopView
{
    ZDTopView *topView = [[ZDTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

- (void)setupBotView
{
    ZDBotView *botView = [[ZDBotView alloc]init];
//    botView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:botView];
    self.botView = botView;
}

/** 重写set方法接受Cell赋值传来的Frame参数 赋值数据,Frame*/
- (void)setStatusFrame:(ZDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    self.topView.statusFrame = _statusFrame;
    self.botView.frame = _statusFrame.toolbarF;
    self.botView.status = _statusFrame.status;
}
@end
