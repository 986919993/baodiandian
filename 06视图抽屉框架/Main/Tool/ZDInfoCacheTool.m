//
//  ZDInfoCacheTool.m
//  IOSBaoDian
//
//  Created by Dong on 14-8-16.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDInfoCacheTool.h"
#import "FMDB.h"
#import "MJExtension.h"
#import "ZDShareModel.h"
#import "ZDShareFrame.h"

@implementation ZDInfoCacheTool
static FMDatabase *_db;
+ (void)initialize
{
    // 0.获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"infos.sqlite"];
    
    // 1.创建数据库
    _db = [FMDatabase databaseWithPath:fileName];
    
    
    
    // 2.打开数据
    if ([_db open]) {
        // 2.1创建表
        
//        BOOL success = [_db executeUpdate:@"DROP TABLE IF EXISTS infos"];
//        if (success) {
//            NSLog(@"删除成功");
//        }else
//        {
//            NSLog(@"删除失败");
//        }
        
        BOOL succ = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS infos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, createTime TEXT NOT NULL, dict BLOB NOT NULL);"];
        if (succ) {
//            NSLog(@"成功");
        }else{
//            NSLog(@"失败");
        }
    }
}
+ (void)saveStatus:(NSDictionary *)json date:(NSString *)date
{
    [_db executeUpdate:@"DELETE FROM infos WHERE 1"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    BOOL success = [_db executeUpdate:@"INSERT INTO infos(createTime,dict) VALUES(?,?)",date,data];
    if (success) {
//        NSLog(@"保存成功");
        
    }else
    {
//        NSLog(@"保存失败");
        
    }
    
}

+ (NSDictionary *)newsStatusWith:(NSString *)date index:(NSInteger)index{
    // 1.查询数据
    FMResultSet *set = nil;
    // 返回前10条数据
    set = [_db executeQuery:@"SELECT * FROM infos LIMIT 1"];
    // 2.取出数据
//    NSMutableArray *models = [NSMutableArray array];
    NSDictionary *dic = [[NSDictionary alloc]init];
    while ([set next]) {
        // 2.1取出微博二进制数据
        NSData *data = [set objectForColumnName:@"dict"];
        //2.2将微博二进制数据转换为字典
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        // 2.3将字典转换为模型

        dic = dict;
    }
    
    return dic;
}

@end
