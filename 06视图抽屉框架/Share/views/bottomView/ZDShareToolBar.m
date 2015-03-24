//
//  DJBBottomVIew.m
//  06视图抽屉框架
//
//  Created by huan on 14-8-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDShareToolBar.h"
#import "ZDShareButton.h"
#import "ZDShareModel.h"

#define DJBButtonWidth 54
#define DJBButtonHeight 25

@interface ZDShareToolBar ()
/**
 *  爽按钮
 */
@property (nonatomic, weak) ZDShareButton *shuangBtn;
/**
 *  坑按钮
 */
@property (nonatomic, weak) ZDShareButton *kengBtn;
/**
 *  评论按钮
 */
@property (nonatomic, weak)ZDShareButton *commentBtn;
/**
 *  分享按钮
 */
@property (nonatomic, strong)UIButton *shareBtn;
/**
 *  花边
 */
@property (nonatomic, strong)UIImageView *bottomImage;

@property (nonatomic,copy) NSString *shuang;
@property (nonatomic,copy) NSString *keng;
@property (nonatomic,copy) NSString *ping;

@end

@implementation ZDShareToolBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.shuangBtn = [self setupBottomBtnWithImageName:@"shuang"];
        [self.shuangBtn addTarget:self action:@selector(buttonClickShuang) forControlEvents:UIControlEventTouchUpInside];
        [self setupShareBtn];
        self.kengBtn = [self setupBottomBtnWithImageName:@"keng"];
        [self.kengBtn addTarget:self action:@selector(buttonClickKeng) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)buttonClickShuang{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"shuangBtnClick" object:self.shuangBtn];
}
- (void)buttonClickPing{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pingBtnClick" object:self.commentBtn];
}
- (void)buttonClickKeng{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"kengBtnClick" object:self.kengBtn];
}
- (void)buttonClickShare:(UIButton *)button{
    [MBProgressHUD showError:@"分享功能暂未开放，敬请期待" toView:self.superview];
}

- (void)setupShareBtn{
    self.shareBtn = [[UIButton alloc] init];
    [self.shareBtn setImage:[UIImage imageWithNamed:@"fenxiang"] forState:UIControlStateNormal];
    self.shareBtn.contentMode = UIViewContentModeCenter;
    [self.shareBtn setBackgroundImage:[UIImage imageWithNamed:@"anniu_kuang"] forState:UIControlStateNormal];
    self.shareBtn.tag = ZDButtonTypeShare;
    [self.shareBtn addTarget:self action:@selector(buttonClickShare:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shareBtn];
}

- (ZDShareButton *)setupBottomBtnWithImageName:(NSString *)imageName{
    ZDShareButton *button = [[ZDShareButton alloc] init];
    [button setBackgroundImage:[UIImage imageWithNamed:@"anniu_kuang"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithNamed:imageName] forState:UIControlStateNormal];
    UIColor *col = ZDColor(90, 190, 243);
    [button setTitleColor:col forState:UIControlStateNormal];
    [button setTitle:self.shuangBtn.shuzi forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    // 130 190 243
    [self addSubview:button];
    return button;
}




- (void)layoutSubviews{
    [super layoutSubviews];
    self.shuangBtn.x = 0;
    self.shuangBtn.y = 0;
    self.shuangBtn.width = DJBButtonWidth;
    self.shuangBtn.height = DJBButtonHeight;
    
    self.kengBtn.x = CGRectGetMaxX(self.shuangBtn.frame);
    self.kengBtn.y = 0;
    self.kengBtn.width = DJBButtonWidth;
    self.kengBtn.height = DJBButtonHeight;
    
    self.commentBtn.width = DJBButtonWidth;
    self.commentBtn.x = self.width - DJBButtonWidth * 2;
    self.commentBtn.height = DJBButtonHeight;
    self.commentBtn.y = 0;
    
    
    self.shareBtn.y = 0;
    self.shareBtn.width = DJBButtonWidth;
    self.shareBtn.x = self.width - DJBButtonWidth;
    self.shareBtn.height = DJBButtonHeight;
    
    self.bottomImage.x = (self.width - self.superview.width) / 2;
    self.bottomImage.y = CGRectGetMaxY(self.shareBtn.frame) ;
    self.bottomImage.width = self.superview.width;
    self.bottomImage.height = self.height - self.shareBtn.height;
}

#pragma mark 懒加载

- (UIImageView *)bottomImage{
    if (!_bottomImage) {
        _bottomImage = [[UIImageView alloc] init];
        _bottomImage.image = [UIImage imageWithNamed:@"nr_bottom"];
        [self addSubview:_bottomImage];
    }
    return _bottomImage;
}
- (void)setStatusModel:(ZDShareModel *)statusModel{
    _statusModel = statusModel;
    [self.commentBtn setTitle:_statusModel.ping forState:UIControlStateNormal];
    [self.shuangBtn setTitle:_statusModel.shuang forState:UIControlStateNormal];
    [self.kengBtn setTitle:_statusModel.keng forState:UIControlStateNormal];

    
    self.shuangBtn.objID = _statusModel.objID;
    self.kengBtn.objID = _statusModel.objID;
    self.commentBtn.objID = _statusModel.objID;
    
    self.shuangBtn.shuzi = _statusModel.shuang;
    self.kengBtn.shuzi = _statusModel.keng;
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    self.shuangBtn.indexPath = _indexPath;
    self.kengBtn.indexPath = _indexPath;
    self.commentBtn.indexPath = _indexPath;
}

@end
