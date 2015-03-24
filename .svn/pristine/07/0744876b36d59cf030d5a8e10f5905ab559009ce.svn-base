//
//  UIImage+NJ.m
//  传智微博
//
//  Created by apple on 14-7-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+NJ.h"
//#import "ZDRootViewController.h"
//#import "UIImageView+WebCache.h"

@implementation UIImage (NJ)


+ (instancetype)imageWithNamed:(NSString *)name
{
    // 0.定义返回的对象
    UIImage *image = nil;
    // 1.判断是否是iOS7
    if (iOS7) {
        // 要在图片名称后面拼接_os7
        NSString *iOS7Name = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:iOS7Name];
    }
    // 2.判断图片是否为nil(因为有的图片是iOS67通用, 没有_os7结尾的图片)
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    
//    ZDRootViewController *root = [[ZDRootViewController alloc]init];
//    NSDictionary *dict = root.userDict;
//    NSString *urlStr =  dict[@"figureurl_qq_2"];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    UIImageView *icon = [[UIImageView alloc]init];
//    [icon sd_setImageWithURL:url];
//    icon.frame = CGRectMake(0, 0, 80, 80);
//    icon.contentMode = UIViewContentModeScaleToFill;
//    image = icon.image;
    // 3.返回图片
    return image;
}
/** 类方法传入一个图片名 返回一张拉伸好的图片 */
+ (instancetype)resizableImageNamed:(NSString *)name
{
    return [self resizableImageNamed:name left:0.5 top:0.5];
}

/* 通过一个类方法传入一个图片名和拉伸范围 返回一个拉伸好的图片 */
+ (instancetype)resizableImageNamed:(NSString *)name left:(CGFloat)leftRatio top:(CGFloat)topRatio
{
    UIImage *image = [UIImage imageWithNamed:name];
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}
@end
