//
//  ZDFindHeaderView.m
//  IOSBaoDian
//
//  Created by Dong on 14-8-15.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDFindHeaderView.h"
#import "ZDSearchBar.h"
@interface ZDFindHeaderView()


@property (nonatomic,strong) ZDSearchBar *searchBar;

@end
@implementation ZDFindHeaderView

+ (instancetype)findHeaderView{
    return [[NSBundle mainBundle]loadNibNamed:@"ZDFindHeaderView" owner:self options:nil][0];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
    }
    return self;
}
- (void)awakeFromNib{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"findHeader"]];
    ZDSearchBar *searchBar = [[ZDSearchBar alloc]init];
    searchBar.frame = CGRectMake(20,self.bounds.size.height - 50, 280, 40);
    searchBar.font = [UIFont systemFontOfSize:14];
    searchBar.placeholder = @"请输入搜索内容";
    self.searchBar = searchBar;
    [self addSubview:searchBar];
}


@end
