//
//  ZDHttpTool.h
//  新浪微博
//
//  Created by Dong on 14-7-16.
//  Copyright (c) 2014年 itbast. All rights reserved.
//  网络请求工具类  封装一个get请求和一个post请求
//  屏蔽对第三方框架的依赖

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^successBlock)(id json);
typedef void (^failureBlock)(NSError *error);

typedef void (^formDataBlock)(id<AFMultipartFormData> formData);
@interface ZDHttpTool : NSObject

/**
 *  封装AFN第三方框架Get请求,降低对第三方框架的依赖
 *
 *  @param url     请求地址
 *  @param params  请求的参数
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;

/**
 *  封装AFN第三方框架Post请求,降低对第三方框架的依赖
 *
 *  @param url     请求地址
 *  @param params  请求的参数
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;
/*
 AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
 
 [manger POST:<#(NSString *)#> parameters:<#(id)#> constructingBodyWithBlock:<#^(id<AFMultipartFormData> formData)block#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>]
 */

/** 向服务器上传一条数据 */
+ (void)postSendWithUrl:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(formDataBlock)block  success:(successBlock)success failure:(failureBlock)failure;

@end
