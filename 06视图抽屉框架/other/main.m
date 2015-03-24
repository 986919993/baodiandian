//
//  main.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BmobSDK/Bmob.h>

//#import <BmobSDK/BmobObject.h>//"BmobObject.h"
//#import <BmobSDK/BmobQuery.h>//"BmobQuery.h"
//#import <BmobSDK/BmobFile.h>

#import "ZDAppDelegate.h"

int main(int argc, char * argv[])
{
    [Bmob registerWithAppKey:@"a29b7e4d73405e478e1499407b621f84"];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([ZDAppDelegate class]));
    }
}
