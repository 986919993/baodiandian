//
//  ZDBotView.m
//  新浪微博
//
//  Created by Dong on 14-7-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDBotView.h"
#import "ZDStatus.h"
#import "ZDStatusFrame.h"

@interface ZDBotView()

/** 转发数 */
@property (nonatomic, weak) UIButton  *repostsBtn;

/** 评论数 */
@property (nonatomic, weak) UIButton  *commentsBtn;

/** 赞数 */
@property (nonatomic, weak) UIButton  *attitudesBtn;

/** 保存所有按钮 */
@property (nonatomic,strong) NSMutableArray *buttons;

/** 保存所有分割线 */
@property (nonatomic,strong) NSMutableArray *dividers;

@end
@implementation ZDBotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // imageView默认不支持用户交互 初始化允许用户交互
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableImageNamed:@"common_card_bottom_background"];
        // 添加一个转发按钮
        self.repostsBtn = [self setupWithIcon:@"timeline_icon_retweet" title:@"转发"];
        // 添加一个评论按钮
        self.commentsBtn = [self setupWithIcon:@"timeline_icon_comment" title:@"评论"];
        // 添加一个赞按钮
        self.attitudesBtn = [self setupWithIcon:@"timeline_icon_unlike" title:@"赞"];
        [self setupDividers];
        [self setupDividers];

    }
    return self;
}

/**
 *  每当有一个子控件添加调用layoutSubviews重新布局子视图
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮Frame
    NSInteger count = self.buttons.count;
    CGFloat btnY = ZERO;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i< count; i++) {
        UIButton *btn = self.buttons[i];
//        CGFloat btnX = btnW * count;
//        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.width = btnW;
        btn.height = btnH;
        btn.y = btnY;
        btn.x = i * btnW;
    }
    
    // 设置分割线Frame
    NSInteger dividerCount = self.dividers.count;
    CGFloat divY = self.height * 0.2;
    CGFloat divW = 1;
    CGFloat divH = self.height * 0.6;
    for (int i = 0; i< dividerCount; i++) {
        UIImageView *div = self.dividers[i];
        CGFloat divX = btnW * (count + 1);
        div.frame = CGRectMake(divX, divY, divW, divH);
    }
}

/** 重写set方法接受传过来的参数设置数据 */
- (void)setStatus:(ZDStatus *)status
{
    _status = status;
//    _status.comments_count = 11000;
    /*
     大于10000 1万
     11000 1.1万
     不大于  按照原样显示
     */
    
    // 设置转发
    [self setBtn:self.repostsBtn count:_status.reposts_count originalTitle:@"转发"];
    // 设置评论
    [self setBtn:self.commentsBtn count:_status.comments_count originalTitle:@"评论"];
    // 设置赞
    [self setBtn:self.attitudesBtn count:_status.attitudes_count originalTitle:@"赞"];
}

- (void)setBtn:(UIButton *)btn count:(int)count originalTitle:(NSString *)originalTitle
{
    if (count) {
        // 有转发
        NSString *countTitle = nil;
        // 判断count是否>= 10000
        if (count >= 10000) {
            /*
             大于10000 1万
             11000 1.1万
             */
            double caculateCount            = count/ 10000.0;
            // 1.0万
            countTitle = [NSString stringWithFormat:@"%.1f万", caculateCount];
            // 对能被整除的数进行特殊处理
            countTitle = [countTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
        }else
        {
            // 不大于  按照原样显示
            countTitle = [NSString stringWithFormat:@"%d", count];
        }
        
        [btn setTitle:countTitle forState:UIControlStateNormal];
    }else
    {
        // 没有转发, 需要重置数据
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}


- (UIButton *)setupWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageWithNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizableImageNamed:@"common_card_bottom_background"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizableImageNamed:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self addSubview:btn];
    [self.buttons addObject:btn];
    return btn;
}

- (void)setupDividers
{
    UIImageView *dividers = [[UIImageView alloc]init];
    dividers.image = [UIImage imageWithNamed:@"timeline_card_bottom_line"];
    [self addSubview:dividers];
    [self.dividers addObject:dividers];
}


#pragma mark 懒加载
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

@end
