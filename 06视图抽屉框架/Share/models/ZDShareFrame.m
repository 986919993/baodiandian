//
//  DJBShareFrame.m
//  06视图抽屉框架
//
//  Created by huan on 14-8-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDShareFrame.h"
#import "ZDShareModel.h"
#define DJBMargin 5
#define DJBScreenWidth [UIScreen mainScreen].bounds.size.width


@implementation ZDShareFrame

- (void)setStatesesModel:(ZDShareModel *)statesesModel{
    _statesesModel = statesesModel;
    
   
    CGFloat topViewX = DJBMargin;
    CGFloat topViewY = DJBMargin;
    CGFloat topViewW = DJBScreenWidth - (DJBMargin * 4);
    CGFloat topViewH = 40;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    CGFloat contextLabelX = DJBMargin;
    CGFloat contextLabelY = CGRectGetMaxY(self.topViewF) + DJBMargin * 2;
    CGFloat contextLabelW = topViewW;
    CGSize maxSize = CGSizeMake(contextLabelW, MAXFLOAT);
    CGSize size = [statesesModel.answer sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:maxSize];
    CGFloat contextLabelH = size.height;
    _contextLabelF = CGRectMake(contextLabelX, contextLabelY, contextLabelW, contextLabelH);
   
    CGFloat bottomViewY = 0;
    if (statesesModel.imageName ) {
        CGFloat shareImageX = DJBMargin ;
        CGFloat shareImageY = CGRectGetMaxY(self.contextLabelF) + DJBMargin;
        CGFloat shareImageW = 100;
        CGFloat shareImageH = 100;
        _shareImageF = CGRectMake(shareImageX, shareImageY, shareImageW, shareImageH);
        bottomViewY = CGRectGetMaxY(self.shareImageF) + DJBMargin;
    }else{
        bottomViewY = CGRectGetMaxY(self.contextLabelF) + DJBMargin;
        _shareImageF = CGRectMake(0, 0, 0, 0);
    }
    
    if (statesesModel.imageName2) {
        CGFloat shareImageX = CGRectGetMaxX(self.shareImageF) + DJBMargin;
        CGFloat shareImageY = CGRectGetMaxY(self.contextLabelF) + DJBMargin;
        CGFloat shareImageW = 100;
        CGFloat shareImageH = 100;
        _shareImage2F = CGRectMake(shareImageX, shareImageY, shareImageW, shareImageH);
    }else{}
    if (statesesModel.imageName3 ) {
        CGFloat shareImageX = CGRectGetMaxX(self.shareImage2F) + DJBMargin;
        CGFloat shareImageY = CGRectGetMaxY(self.contextLabelF) + DJBMargin;
        CGFloat shareImageW = 100;
        CGFloat shareImageH = 100;
        _shareImage3F = CGRectMake(shareImageX, shareImageY, shareImageW, shareImageH);
    }

    CGFloat bottomViewX = DJBMargin;
    CGFloat bottomViewW = topViewW;
    CGFloat bottomViewH = 30;
    _bottomViewF = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    
    CGFloat bgViewX = DJBMargin;
    CGFloat bgViewY = DJBMargin;
    CGFloat bgViewW = DJBScreenWidth - DJBMargin * 2;
    CGFloat bgViewH = CGRectGetMaxY(_bottomViewF);
    _bgViewF = CGRectMake(bgViewX, bgViewY, bgViewW, bgViewH);
    
    _cellHeight = CGRectGetMaxY(self.bottomViewF) + 10;
}

@end
