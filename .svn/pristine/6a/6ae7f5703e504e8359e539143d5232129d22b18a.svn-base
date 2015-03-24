//
//  ZDHttpTool.m
//  新浪微博
//
//  Created by Dong on 14-7-16.
//  Copyright (c) 2014年 itbast. All rights reserved.
//  网络请求工具类

#import "ZDHttpTool.h"
#import "AFNetworking.h"

@implementation ZDHttpTool

/**
 *  封装AFN第三方框架Get请求,降低对第三方框架的依赖
 *
 *  @param url     请求地址
 *  @param params  请求的参数
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    // 实例化请求管理器
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    // 调用GET请求方法 传入请求地址,和参数
    [man GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 成功的回调
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失败的回调
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  封装AFN第三方框架Post请求,降低对第三方框架的依赖
 *
 *  @param url     请求地址
 *  @param params  请求的参数
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    // 实例化请求管理器
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    // 调用Post请求方法传入 请求地址,请求参数
    [man POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 成功的回调
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失败的回调
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)postSendWithUrl:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(formDataBlock)block success:(successBlock)success failure:(failureBlock)failure
{
    // 实例化请求管理器
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    [man POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (block) {
            block(formData);
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 成功的回调
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失败的回调
        if (failure) {
            failure(error);
        }
    }];
}



@end
