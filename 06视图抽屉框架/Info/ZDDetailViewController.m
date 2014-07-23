//
//  ZDDetailViewController.m
//  兄弟连
//
//  Created by Dong on 14-7-4.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDDetailViewController.h"
#import "ZDDetailHeardCell.h"
#import "ZDBaseDetailCell.h"
#import "ZDDetailCell.h"
#import "NSString+Path.h"

static NSString *heardCell = @"heardCell";
static NSString *detailCell = @"detailCell";
static NSString *footCell = @"footCell";
static NSString *photosCell = @"photosCell";
static NSString *commentCell = @"commentCell";

@interface ZDDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZDDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setting];
}

- (void) setting
{
    self.navigationItem.title = @"详细";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *heardNib = [UINib nibWithNibName:@"ZDDetailHeardCell" bundle:nil];
    [self.tableView registerNib:heardNib forCellReuseIdentifier:heardCell];
    
    UINib *footNib = [UINib nibWithNibName:@"ZDFootCell" bundle:nil];
    [self.tableView registerNib:footNib forCellReuseIdentifier:footCell];
    
    UINib *photosNib = [UINib nibWithNibName:@"ZDPhotosCell" bundle:nil];
    [self.tableView registerNib:photosNib forCellReuseIdentifier:photosCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (void)setInfoModel:(ZDInfoModel *)infoModel
{
    _infoModel = infoModel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDBaseDetailCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:heardCell];
    }else if(indexPath.row == 1){
        cell = [self.tableView dequeueReusableCellWithIdentifier:detailCell];
        if (cell == nil) {
            cell = [[ZDDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCell];
        }
    }else if(indexPath.row == 2){
        cell = [self.tableView dequeueReusableCellWithIdentifier:footCell];
    }else{
        cell = [self.tableView dequeueReusableCellWithIdentifier:photosCell];
    }
    cell.infoModel = _infoModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else if(indexPath.row == 1){
        CGSize size = [self.infoModel.detail sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(300, MAXFLOAT)];
        return size.height+10;
    }else if(indexPath.row == 2){
        return 100;
    }else{
        return 68;
    }
}

@end
