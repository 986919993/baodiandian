//
//  ZDTopView.m
//  新浪微博
//
//  Created by Dong on 14-7-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDTopView.h"
#import "ZDStatusOriginalView.h"
#import "ZDStatusRepostedView.h"
#import "ZDStatusFrame.h"
#import "ZDStatus.h"

@interface ZDTopView()

@property (nonatomic,weak) ZDStatusOriginalView *originalView;

@property (nonatomic,weak) ZDStatusRepostedView *repostedView;

@end
@implementation ZDTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 设置顶部视图的图片
        self.image = [UIImage resizableImageNamed:@"common_card_background"];
        // 加载原创微博视图
        [self setupOriginalView];
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

/**
 *  加载原创微博
 */
- (void)setupOriginalView
{
    // 1.原创微博
    ZDStatusOriginalView *originalView = [[ZDStatusOriginalView alloc] init];
//    originalView.backgroundColor = [UIColor grayColor];
    [self addSubview:originalView];
    self.originalView = originalView;
    
}


- (void)setStatusFrame:(ZDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
#warning 注意一定要设置topview自己的frame
    // 1.设置topview自己的frame
    self.frame = _statusFrame.topViewF;
    // 2.传递模型给原创微博
    self.originalView.statusFrame = _statusFrame;
    // 3.传递模型给转发微博
    self.repostedView.statusFrame = _statusFrame;
}

@end
