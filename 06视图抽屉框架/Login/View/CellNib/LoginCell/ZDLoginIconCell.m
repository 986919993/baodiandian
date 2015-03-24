//
//  ZDLoginIconCell.m
//  06视图抽屉框架
//
//  Created by wuzhe on 14-8-5.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDLoginIconCell.h"


@interface ZDLoginIconCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ZDLoginIconCell

@synthesize info = _info;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        // Initialization code
        [self alterIconView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self alterIconView];
}

- (void)alterIconView
{
    [self.iconView.layer setMasksToBounds:YES];
    [self.iconView.layer setCornerRadius:30];
}

- (void)setInfo:(ZDLoginInfoModel *)info
{
   
}



+(CGFloat)rowHeight
{
    return 70;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    ZDLog(@"iconView");
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZDLoginIcon" object:nil];
//    
//    
//}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
