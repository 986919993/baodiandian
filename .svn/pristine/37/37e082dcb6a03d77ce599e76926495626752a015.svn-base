//
//  ZDItemCell.m
//  06视图抽屉框架
//
//  Created by Dong on 14-8-1.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDItemCell.h"
#import "ZDZanButton.h"

@interface ZDItemCell()

@property (weak, nonatomic) IBOutlet ZDZanButton *zan;
@property (weak, nonatomic) IBOutlet UILabel *title;


@end
@implementation ZDItemCell

- (void)awakeFromNib
{

}
- (IBAction)zan:(id)sender {
    NSLog(@"赞按钮");
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.zan.zan = dict[@"zan"];
    self.title = dict[@"title"];
}
+ (CGFloat)cellHeight{
    return 60;
}

@end
