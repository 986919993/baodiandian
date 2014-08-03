//
//  ZDStatusOriginalView.m
//  新浪微博
//
//  Created by Dong on 14-7-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDStatusOriginalView.h"
#import "ZDPhotosView.h"
#import "ZDStatus.h"
#import "ZDUser.h"
#import "ZDStatusFrame.h"
#import "UIImageView+WebCache.h"

@interface ZDStatusOriginalView()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 配图 */
@property (nonatomic, weak) ZDPhotosView *photosView;

@end
@implementation ZDStatusOriginalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor purpleColor];
        
        /** 2.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
//        iconView.backgroundColor = [UIColor redColor];

        /** 3.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        nameLabel.font = ZDNameFont;

        /** 4.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        self.vipView = vipView;
        vipView.contentMode = UIViewContentModeCenter;

        /** 5.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        timeLabel.font = ZDTimeFont;
        timeLabel.textColor = [UIColor orangeColor];

        /** 6.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        sourceLabel.font = ZDTimeFont;
        
        /** 7.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        // 设置正文自动换行
        contentLabel.numberOfLines = 0;
        contentLabel.font = ZDContentFont;
        
        /** 8.配图 */
        ZDPhotosView *photoView = [[ZDPhotosView alloc] init];
        [self addSubview:photoView];
        self.photosView = photoView;
    }
    return self;
}

- (void)setStatusFrame:(ZDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    [self setupData];
    [self setupFrame];
}

/** 加载数据 */
- (void)setupData
{
    // 取出模型数据
    ZDStatus *status = self.statusFrame.status;
    ZDUser *user = status.user;
    // 1.设置头像数据
    NSURL *iconUrl = [NSURL URLWithString:user.profile_image_url];
    [self.iconView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
    // 2.设置昵称数据
    self.nameLabel.text = user.name;
    // 3.会员标志
    if (user.isVip) {
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageWithNamed:imageName];
        self.vipView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    self.timeLabel.text = status.created_at;
    self.sourceLabel.text = status.source;
    self.contentLabel.text = status.text;
    self.photosView.photos = status.pic_urls;
}

/** 加载Frame */
- (void)setupFrame
{
    
    ZDStatusFrame *statusFrame = self.statusFrame;
    ZDStatus *status = statusFrame.status;
    self.iconView.frame = statusFrame.iconViewF;
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.vipView.frame = statusFrame.vipViewF;
    // 计算时间Farme  Tue May 31 17:46:55 +0800 2011
    CGFloat timeX  = statusFrame.nameLabelF.origin.x;
    CGFloat timeY  = CGRectGetMaxY(statusFrame.nameLabelF) + 3;
    NSString *time = status.created_at;
    CGSize timeSize = [time sizeWithFont:ZDTimeFont];
    self.timeLabel.frame = (CGRect){{timeX , timeY}, timeSize};
    // 计算来源Farme
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame);
    CGFloat sourceY = timeY;
    NSString *source = status.source;
    CGSize sourceSize = [source sizeWithFont:ZDSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};

    // 设置正文Frame
    self.contentLabel.frame = statusFrame.contentLabelF;
    // 设置原创微博Frame
    self.frame = statusFrame.originalViewF;
    // 设置配图Farme
    self.photosView.frame = statusFrame.photoViewF;
    
}


@end
