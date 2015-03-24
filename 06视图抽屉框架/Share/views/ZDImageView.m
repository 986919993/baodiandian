//
//  ZDImageView.m
//  IOSBaoDian
//
//  Created by Dong on 14-8-16.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDImageView.h"

@implementation ZDImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置属性
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setYincang:(BOOL)yincang{
    _yincang = yincang;
    if (_yincang) {
        self.hidden = YES;
    }
}
- (void)setUrl:(NSString *)url{
    _url = url;
    
    NSURL *imageURL = [NSURL URLWithString:_url];
    
    if (url) {
        self.hidden = NO;
        [self sd_setImageWithURL:imageURL placeholderImage:[UIImage imageWithNamed:@"lol"]];
    }else{
        self.hidden = YES;
    }
}


@end
