//
//  ZDPhotoView.m
//  新浪微博
//
//  Created by Dong on 14-7-13.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDPhotoView.h"
#import "ZDPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface ZDPhotoView()

@property (nonatomic,strong) UIImageView *gifView;

@end
@implementation ZDPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeCenter;
//        self.contentMode = UIViewContentModeScaleAspectFill;
//        self.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc]initWithImage:[UIImage imageWithNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
        gifView.hidden = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

- (void)setPhoto:(ZDPhoto *)photo
{
    _photo = photo;
    NSURL *photoUrl = [NSURL URLWithString:_photo.thumbnail_pic];
    
    [self sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
    if ([_photo.thumbnail_pic.lowercaseString hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}

@end
