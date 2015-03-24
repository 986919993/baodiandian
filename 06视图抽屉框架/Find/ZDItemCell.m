//
//  ZDItemCell.m
//  06视图抽屉框架
//
//  Created by Dong on 14-8-1.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDItemCell.h"
#import "ZDZanButton.h"
#import "ZDDataTool.h"

@interface ZDItemCell()

@property (weak, nonatomic) IBOutlet ZDZanButton *zan;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic,strong) NSNumber *cellID;

@end
@implementation ZDItemCell

- (void)awakeFromNib
{

}
- (IBAction)zan:(id)sender {
    NSString *str = [NSString stringWithFormat:@"%@",self.dict[@"zan"]];
    NSInteger inter = [str intValue];
    [ZDDataTool updata:self.cellID zan:inter];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickZan" object:self.cellID];
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.zan.zan = dict[@"zan"];
    self.title.text = dict[@"title"];
    self.cellID = dict[@"dataID"];
}

+ (CGFloat)cellHeight{
    return 55;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
