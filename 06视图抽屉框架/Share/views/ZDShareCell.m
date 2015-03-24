//
//  DJBShareCell.m
//  06视图抽屉框架
//
//  Created by huan on 14-8-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDShareCell.h"
#import "ZDShareToolBar.h"
#import "ZDShareTopView.h"
#import "ZDShareFrame.h"
#import "ZDShareModel.h"
#import "UIImageView+WebCache.h"
#import "ZDImageView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

//#import "ZDShareViewController.h"
@interface ZDShareCell ()

@property (nonatomic, strong) UIImageView *bjImage;

@property (nonatomic, strong) UIView *bgView;

/**
 *  顶部视图（包括个人头像，昵称，分享时间，分享正文）
 */
@property (nonatomic, weak) ZDShareTopView *topView;
/**
 *  分享正文
 */
@property (nonatomic, weak) UILabel *contextLabel;
/**
 *  分享图片视图
 */
@property (nonatomic, weak) ZDImageView *shareImage;
@property (nonatomic, weak) ZDImageView *shareImage2;
@property (nonatomic, weak) ZDImageView *shareImage3;
/**
 *  底部视图（包括赞，评论，和分享共3个按钮）
 */
@property (nonatomic, weak) ZDShareToolBar *bottomView;

@end

@implementation ZDShareCell

+ (instancetype)cellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"share";
    ZDShareCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZDShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView = self.bjImage;
        self.contentView.userInteractionEnabled = YES;
//        初始化所有可能用到的子控件
//        设置头部视图
        [self setupTopView];
//        设置分享正文视图
        [self setupContextView];
//        设置分享图片视图
        [self setupImageView];
//        设置底部视图
        [self setupBottomView];
    }
    return self;
}
/**
 *  设置头部视图
 */
- (void)setupTopView{
    ZDShareTopView *topView = [[ZDShareTopView alloc] init];
    [self.bgView addSubview:topView];
    self.topView = topView;
}


/**
 *  设置分享图片视图
 */
- (void)setupContextView{
    UILabel *contextlabel = [[UILabel alloc] init];
//    contextlabel.backgroundColor = [UIColor lightGrayColor];
    [self.bgView addSubview:contextlabel];
    self.contextLabel = contextlabel;
}

/**
 *   设置分享图片视图
 */
- (void)setupImageView{
    ZDImageView *shareImage = [[ZDImageView alloc] init];
    [self.bgView addSubview:shareImage];
    self.shareImage = shareImage;
    
    ZDImageView *shareImage2 = [[ZDImageView alloc] init];
    [self.bgView addSubview:shareImage2];
    self.shareImage2 = shareImage2;
    
    ZDImageView *shareImage3 = [[ZDImageView alloc] init];
    [self.bgView addSubview:shareImage3];
    self.shareImage3 = shareImage3;
}

/**
 *  设置底部视图
 */
- (void)setupBottomView{
    ZDShareToolBar *bottomView = [[ZDShareToolBar alloc] init];
    [self.bgView addSubview:bottomView];
    self.bottomView = bottomView;
}

-(void)setShareFrame:(ZDShareFrame *)shareFrame
{
    _shareFrame = shareFrame;
    ZDShareModel *statusesModel = _shareFrame.statesesModel;
    _shareFrame.statesesModel = statusesModel;
    
    self.topView.frame = _shareFrame.topViewF;
    self.topView.shareFrame = _shareFrame;
    
    self.contextLabel.frame = _shareFrame.contextLabelF;
    self.contextLabel.numberOfLines = 0;
    self.contextLabel.text = statusesModel.answer;
    self.contextLabel.font = [UIFont systemFontOfSize:15];
    
    self.shareImage.url = statusesModel.imageName;
    self.shareImage2.url = statusesModel.imageName2;
    self.shareImage3.url = statusesModel.imageName3;
    
    if (statusesModel.imageName) {
        self.shareImage.frame = _shareFrame.shareImageF;
    }
    if (statusesModel.imageName2) {
        self.shareImage2.frame = _shareFrame.shareImage2F;
    }
    if (statusesModel.imageName3) {
        self.shareImage3.frame = _shareFrame.shareImage3F;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
    [self.shareImage addGestureRecognizer:tap];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
    [self.shareImage2 addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
    [self.shareImage3 addGestureRecognizer:tap3];
    
    self.bottomView.frame = _shareFrame.bottomViewF;
    self.bgView.frame = _shareFrame.bgViewF;
    self.bottomView.statusModel = statusesModel;
}
- (void)photoClick:(UITapGestureRecognizer *)tap{
    ZDShareModel *statusesModel = _shareFrame.statesesModel;
    _shareFrame.statesesModel = statusesModel;
    NSMutableArray *array = [NSMutableArray array];
    
    UIImageView *imageView1 = [[UIImageView alloc]init];
    UIImageView *imageView2 = [[UIImageView alloc]init];
    UIImageView *imageView3 = [[UIImageView alloc]init];
    
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc]init];
    
    
    MJPhoto *photo1 = [[MJPhoto alloc]init];
    photo1.url = [NSURL URLWithString:statusesModel.imageName];
    photo1.srcImageView = imageView1;
    if (photo1.url) {
        [array addObject:photo1];
    }
    
    MJPhoto *photo2 = [[MJPhoto alloc]init];
    photo2.url = [NSURL URLWithString:statusesModel.imageName2];
    photo2.srcImageView = imageView2;
    if (photo2.url) {
        [array addObject:photo2];
    }
    MJPhoto *photo3 = [[MJPhoto alloc]init];
    photo3.url = [NSURL URLWithString:statusesModel.imageName3];
    photo3.srcImageView = imageView3;
    if (photo3.url) {
        [array addObject:photo3];
    }
    photoBrowser.photos = array;
    photoBrowser.currentPhotoIndex = 0;
    [photoBrowser show];
}

#pragma  mark 懒加载
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.userInteractionEnabled = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UIImageView *)bjImage{
    if (!_bjImage) {
        _bjImage = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"title_bg"]];
    }
    return _bjImage;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    self.bottomView.indexPath = _indexPath;
}

@end
