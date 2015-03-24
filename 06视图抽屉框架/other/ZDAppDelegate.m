//
//  ZDAppDelegate.m
//  06视图抽屉框架
//
//  Created by Dong on 14-6-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDAppDelegate.h"
#import "ZDRootViewController.h"
#import "ZDSpecialViewController.h"
#import "UIImageView+WebCache.h"
#import "APService.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobObject.h>//"BmobObject.h"
#import <BmobSDK/BmobQuery.h>//"BmobQuery.h"
#import <BmobSDK/BmobFile.h>
#import "RESideMenu.h"
#import "ZDMenuViewController.h"
#import "ZDNavViewController.h"
#import "ZDInfoViewController.h"
@implementation ZDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    // Required
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)];
//    // Required
//    [APService setupWithOption:launchOptions];
    // 以下四个接口是必须调用的
//    [APService registerForRemoteNotificationTypes:<#(int)#>]
//    [APService registerDeviceToken:<#(NSData *)#>]
    
//    regular   compact
//    + (void)setupWithOption:(NSDictionary *)launchingOption;  // 初始化
//    + (void)registerForRemoteNotificationTypes:(int)types;    // 注册APNS类型
//    + (void)registerDeviceToken:(NSData *)deviceToken;  // 向服务器上报Device Token
//    + (void)handleRemoteNotification:(NSDictionary *)
//    remoteInfo;  // 处理收到的APNS消息，向服务器上报收到APNS消息
//    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    application.statusBarHidden = NO;
    [application setStatusBarStyle:UIStatusBarStyleLightContent];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = [[ZDRootViewController alloc]init];
    
    ZDNavViewController *navigationController = [[ZDNavViewController alloc] initWithRootViewController:[[ZDInfoViewController alloc] init]];
    ZDMenuViewController *leftMenuViewController = [[ZDMenuViewController alloc] init];
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"root2.png"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 1;
    sideMenuViewController.contentViewShadowRadius = 0;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
    self.window.backgroundColor = [UIColor redColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"处理推送消息%@",userInfo); //  我了个擦擦   进不来这方法。。
// userInfoquired
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 让程序进入到后台的时候继续执行timer
    // 并不是说只要写上这句代码timer就永远会在后台执行,
    // 应用程序会在iOS系统内存不足的时候被释放
//    UIBackgroundTaskIdentifier taskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        // 关闭后台任务
//        [[UIApplication sharedApplication] endBackgroundTask:taskId];
//    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    // 应该在该方法中释放掉不需要的内存
    // 1.停止所有的子线程下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2.清空SDWebImage保存的所有内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


@end
