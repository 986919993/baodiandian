//
//  ZDStatusRepostedView.m
//  新浪微博
//
//  Created by Dong on 14-7-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDStatusRepostedView.h"
#import "ZDUser.h"
#import "ZDStatus.h"
#import "ZDStatusFrame.h"
#import "ZDPhotosView.h"

@interface ZDStatusRepostedView()

/** 转发微博昵称 */
@property (nonatomic, weak) UILabel *repostedNameLabel;
/** 转发微博正文 */
@property (nonatomic, weak) UILabel *repostedContentLabel;
/** 配图 */
@property (nonatomic, weak) ZDPhotosView  *repostedPhotosView;

@end

@implementation ZDStatusRepostedView

/** 初始化所有子控件 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置转发微博背景图片
        self.backgroundColor =  [UIColor colorWithPatternImage:[UIImage resizableImageNamed:@"timeline_retweet_background"]];
        // 设置转发微博昵称
        UILabel *repostedNameLabel = [[UILabel alloc] init];
        [self addSubview:repostedNameLabel];
        self.repostedNameLabel = repostedNameLabel;
        repostedNameLabel.font = ZDRepostedNameFont;
        repostedNameLabel.textColor = [UIColor brownColor];
        
        // 设置转发微博正文
        UILabel *repostedContentLabel = [[UILabel alloc] init];
        [self addSubview:repostedContentLabel];
        self.repostedContentLabel = repostedContentLabel;
        repostedContentLabel.font = ZDRepostedContentFont;
        repostedContentLabel.numberOfLines = 0;
        
        // 设置配图
        ZDPhotosView *photoView = [[ZDPhotosView alloc]init];
        [self addSubview:photoView];
        self.repostedPhotosView = photoView;
        self.userInteractionEnabled = YES;
    }
    return self;
}


@end
