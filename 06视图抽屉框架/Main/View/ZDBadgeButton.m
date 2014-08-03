//
//  ZDBadgeButton.m
//  新浪微博
//
//  Created by Dong on 14-7-20.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDBadgeButton.h"

@implementation ZDBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizableImageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.size = self.currentBackgroundImage.size;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if (badgeValue.intValue) {
        self.hidden = NO;
        NSString *value = nil;
        if (badgeValue.intValue >= 100) {
            value = @"N";
        }else{
            value = badgeValue;
        }
        [self setTitle:value forState:UIControlStateNormal];
    }else{
        self.hidden = YES;
    }
}


@end
