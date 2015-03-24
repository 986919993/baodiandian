//
//  ZDCommonCell.m
//  新浪微博
//
//  Created by Dong on 14-7-17.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDCommonCell.h"
#import "ZDCommonItem.h"
#import "ZDCommonLabelItem.h"
#import "ZDCommonSwitchItem.h"
#import "ZDCommonGroup.h"
#import "ZDCommonCheckItem.h"
#import "ZDCommonCheckGroup.h"
#import "ZDCommonArrowItem.h"
#import "ZDBadgeButton.h"

@interface ZDCommonCell()

@property (nonatomic,strong) UISwitch *rightSwitch;

@property (nonatomic,strong) UILabel *rightLabel;

@property (nonatomic,strong) UIImageView *rightArrow;

@property (nonatomic,strong) UIImageView *rightChecked;

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) ZDBadgeButton *badgeButton;

@end

@implementation ZDCommonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.设置文字大小
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        // 2.设置背景图片
        // backgroundView的优先级大于backgroundColor
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc ] init];
        self.selectedBackgroundView = [[UIImageView alloc ] init];
        // 3.设置iOS6下高亮状态的颜色
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor;
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    ZDCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZDCommonCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(void)setItem:(ZDCommonItem *)item
{
    _item = item;
    self.imageView.image = [UIImage imageWithNamed:_item.icon];
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subtitle;
    
    
    [self setupRight];
}

/**
 *  设置右边辅助视图类型
 */
- (void)setupRight
{
    if (self.item.badgeValue.intValue) {
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    }else if ([self.item isKindOfClass:[ZDCommonLabelItem class]]){
        self.accessoryView = self.rightLabel;
        ZDCommonLabelItem *label = (ZDCommonLabelItem *)self.item;
        self.rightLabel.text = label.text;
    }else if([self.item isKindOfClass:[ZDCommonSwitchItem class]])
    {
        // 设置右边为switch
        self.accessoryView = self.rightSwitch;
        
    }else if ([self.item isKindOfClass:[ZDCommonArrowItem class]])
    {
        // 设置右边为剪头
        self.accessoryView = self.rightArrow;
    }else if ([self.item isKindOfClass:[ZDCommonCheckItem class]])
    {
        // 设置右边为打勾
        // 1.取出对应行的模型
        ZDCommonCheckItem *item = (ZDCommonCheckItem *)self.item;
        // 2.判断是否需要显示打勾
        if (item.isChecked) {
            self.accessoryView = self.rightChecked;
        }else{
            self.accessoryView = nil;
        }
    }else{
        // 没有辅助视图
        self.accessoryView = nil;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    // 根据行号设置背景图片
    // 获取背景图片
    UIImageView *normalBg = (UIImageView *)self.backgroundView;
    UIImageView *selectedBg = (UIImageView *)self.selectedBackgroundView;
    
    // 获取当前组一共有多少行
    NSInteger totalRow =  [self.tableView numberOfRowsInSection:indexPath.section];
    
    if (1 == totalRow) {
        // 当前组只有一行数据
        normalBg.image = [UIImage resizableImageNamed:@"common_card_background"];
        selectedBg.image = [UIImage resizableImageNamed:@"common_card_background_highlighted"];
        
        self.backgroundView = normalBg;
        self.selectedBackgroundView = selectedBg;
        
    }else if (0 == indexPath.row) {
        // 是当前这一组的第0行
        normalBg.image = [UIImage resizableImageNamed:@"common_card_top_background"];
        selectedBg.image = [UIImage resizableImageNamed:@"common_card_top_background_highlighted"];
        
        self.backgroundView = normalBg;
        self.selectedBackgroundView = selectedBg;
        
    }else if ((totalRow - 1) == indexPath.row)
    {
        // 是当前组的最后一行
        normalBg.image = [UIImage resizableImageNamed:@"common_card_bottom_background"];
        selectedBg.image = [UIImage resizableImageNamed:@"common_card_bottom_background_highlighted"];
        self.backgroundView = normalBg;
        self.selectedBackgroundView = selectedBg;
    }else
    {
        // 中间的行
        normalBg.image = [UIImage resizableImageNamed:@"common_card_middle_background"];
        selectedBg.image = [UIImage resizableImageNamed:@"common_card_middle_background_highlighted"];
        
        self.backgroundView = normalBg;
        self.selectedBackgroundView = selectedBg;
    }
}

#pragma mark - 拦截系统设置cell的frame, 然后修改cell的Y值
- (void)setFrame:(CGRect)frame
{
    // ios6时cell未填满整个屏幕
    if (!iOS7) {
        // 拦截系统的set方法从新计算frame
        frame.origin.x -= 10;
        frame.size.width += 20;
    }
    [super setFrame:frame];
}

#pragma mark - 懒加载
- (UIImageView *)rightArrow
{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UIImageView *)rightChecked
{
    if (!_rightChecked) {
        _rightChecked = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"common_icon_checkmark"]];
    }
    return _rightChecked;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

- (UISwitch *)rightSwitch
{
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}
- (ZDBadgeButton *)badgeButton
{
    if (!_badgeButton) {
        _badgeButton = [[ZDBadgeButton alloc] init];
    }
    return _badgeButton;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    //    IWLog(@"layoutSubviews = %@", NSStringFromCGRect(self.contentView.frame));
    // 设置子标题的位置
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
}



@end
