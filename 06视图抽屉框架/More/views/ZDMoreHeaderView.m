//
//  ZDHeaderView.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDMoreHeaderView.h"
#import "UIImageView+WebCache.h"
#import "ZDAccount.h"
#import "ZDAccountTool.h"

@interface ZDMoreHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userSign;

@property (nonatomic,strong) ZDAccount *account;
@end
@implementation ZDMoreHeaderView

+ (instancetype)moreHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ZDMoreHeaderView" owner:nil options:nil][0];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL isLogin = (self.account.nickname !=nil);
    if ([self.headerDelegate respondsToSelector:@selector(didClickHeaderView:)]) {
        [self.headerDelegate didClickHeaderView:isLogin];
    }
}

- (void)awakeFromNib{
    UIImageView *imageView = [[UIImageView alloc]init];
    ZDAccount *account = [ZDAccountTool account];
    self.account = account;
    if (account.nickname.length >0) {
        NSURL *url = [NSURL URLWithString:account.figureurl_qq_2];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"lol"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            UIImage *userImage = [imageView image];
            [self.userIcon setImage:userImage];
            
            UIImage *oldImage =  [self.userIcon image];
            
            UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
            
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextAddEllipseInRect(ctx, CGRectMake(2, 2, oldImage.size.width, oldImage.size.height));
            CGContextClip(ctx);
            [oldImage drawInRect:CGRectMake(2, 2, oldImage.size.width, oldImage.size.height)];
            self.userIcon.image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            self.userName.text = account.nickname;
        }];
    }else{
        self.userName.text = @"点击头像登陆";
    }
    
    UIImage *oldImage = [self.userIcon image];
    
    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(2, 2, oldImage.size.width, oldImage.size.height));
    CGContextClip(ctx);
    [oldImage drawInRect:CGRectMake(2, 2, oldImage.size.width, oldImage.size.height)];
    self.userIcon.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
