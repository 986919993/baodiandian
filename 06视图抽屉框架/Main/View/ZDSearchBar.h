//
//  ZDSearchBar.h
//  新浪微博
//
//  Created by Dong on 14-7-8.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDSearchBarDelegate <NSObject>

- (void)searchBarDidChanged:(NSString *)text;

@end
@interface ZDSearchBar : UITextField <UITextFieldDelegate>

@property (nonatomic,weak) id<ZDSearchBarDelegate> searchBarDelegate;

@end
