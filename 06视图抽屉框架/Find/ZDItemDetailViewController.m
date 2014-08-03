//
//  ZDItemDetailViewController.m
//  06视图抽屉框架
//
//  Created by Dong on 14-8-1.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDItemDetailViewController.h"

@interface ZDItemDetailViewController ()

@property (nonatomic,strong) UILabel *detail;
@end

@implementation ZDItemDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"详细内容";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemDetailID = @"itemDetail";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:itemDetailID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemDetailID];
    }
    cell.textLabel.text = self.dict[@"detail"];
    
    return cell;
}
@end
