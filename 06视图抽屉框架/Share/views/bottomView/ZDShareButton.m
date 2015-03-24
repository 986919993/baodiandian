//
//  DJBButton.m
//  06视图抽屉框架
//
//  Created by huan on 14-8-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDShareButton.h"

@implementation ZDShareButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(self.width * 0.55, 0, self.width * 0.5, self.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(5, 0, self.width * 0.5, self.height);
}
- (void)setShuzi:(NSString *)shuzi{
    _shuzi = shuzi;
    self.titleLabel.text = shuzi;
}
- (void)setObjID:(NSString *)objID{
    _objID = objID;
}

@end
