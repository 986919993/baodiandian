//
//  ZDPhotoView.m
//  新浪微博
//
//  Created by Dong on 14-7-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDPhotosView.h"
#import "ZDPhotoView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "ZDPhotosView.h"
#import "UIImageView+WebCache.h"
#import "ZDPhoto.h"

@implementation ZDPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        for (int i = 0; i< 9; i++) {
            ZDPhotoView *photo = [[ZDPhotoView alloc]initWithFrame:self.bounds];
            photo.tag = i;
            [self addSubview:photo];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClick:)];
            [photo addGestureRecognizer:tap];
            self.clipsToBounds = YES;

        }
    }
    return self;
}
- (void)photoClick:(UITapGestureRecognizer *)tap
{
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc]init];
    int count = self.photos.count;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        MJPhoto *photo = [[MJPhoto alloc]init];
        ZDPhoto *p = self.photos[i];
        photo.url = [NSURL URLWithString:p.bmiddle_pic];
        photo.srcImageView = self.subviews[i];
        [array addObject:photo];
    }
    photoBrowser.photos = array;
    photoBrowser.currentPhotoIndex = tap.view.tag;
    [photoBrowser show];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    int photoCount = _photos.count;
    
    if (photoCount) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
    for (int i = 0; i < 9; i++) {
        ZDPhotoView *photoView = self.subviews[i];
        if (i<photoCount) {
            photoView.hidden = NO;
            ZDPhoto *photo = _photos[i];
            photoView.photo = photo;
        }else{
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        int row = i / 3;
        CGFloat photoY = row * (ZDPadding + ZDPhotoW);
        int col = i % 3;
        CGFloat photoX = col * (ZDPadding + ZDPhotoH);
        UIImageView *image = self.subviews[i];
        CGFloat x = photoX;
        CGFloat y = photoY;
        CGFloat w = ZDPhotoW;
        CGFloat h = ZDPhotoH;
        image.frame = CGRectMake(x, y, w, h);
    }
    
}



@end
