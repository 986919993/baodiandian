//
//  ZDCommonCheckGroup.m
//  新浪微博
//
//  Created by Dong on 14-7-17.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDCommonCheckGroup.h"
#import "ZDCommonCheckItem.h"

@implementation ZDCommonCheckGroup
- (void)setCheckedIndex:(int)checkedIndex
{
    _checkedIndex = checkedIndex;
    int count = self.items.count;
    for (int i=0; i<count; i++) {
        ZDCommonCheckItem *item = self.items[i];
        if (i==checkedIndex) {
            item.checked = YES;
        }else{
            item.checked = NO;
        }
    }
}

- (void)setItems:(NSArray *)items
{
    [super setItems:items];
    // 重新设置选中的行
    //    self.checkedIndex = self.checkedIndex;
    [self setCheckedIndex:[self checkedIndex]];
}
@end
