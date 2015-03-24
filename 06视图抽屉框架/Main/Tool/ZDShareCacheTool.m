//
//  IWCacheStatusTool.m
//  传智微博
//
//  Created by apple on 14-7-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDShareCacheTool.h"
#import "FMDB.h"
#import "MJExtension.h"
#import "ZDShareModel.h"
#import "ZDShareFrame.h"


@implementation ZDShareCacheTool

static FMDatabase *_db;
static FMDatabaseQueue *_queue;
static NSArray *_menus;
+ (void)initialize
{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"share.sqlite"];
    //    NSString *fileName = [[NSBundle mainBundle]pathForResource:@"shiti.sqlite" ofType:nil];
	// 1.获得数据库对象
    _db = [FMDatabase databaseWithPath:fileName];
    // 1.活的数据库队列对象
    _queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    // 2.在数据库队列中执行线程安全的操作
    
    [_queue inDatabase:^(FMDatabase *db) {
        if ([_db open]) {
//        BOOL success = [_db executeUpdate:@"DROP TABLE IF EXISTS share"];
//        if (success) {
//            NSLog(@"删除成功");
//        }else
//        {
//            NSLog(@"删除失败");
//        }
            ;
            // 2.1创建表
            BOOL suc =  [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS share(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, createTime TEXT UNIQUE NOT NULL, dict BLOB NOT NULL);"];
            if (suc) {
//                NSLog(@"创建表成功");
            }else
            {
//                NSLog(@"创建表失败");
            }
        }
    }];
}


+ (void)saveStatus:(NSDictionary *)json date:(NSString *)date
{
//    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    BOOL success = [_db executeUpdate:@"INSERT INTO share(createTime,dict) VALUES(?,?)",date,data];
//    NSLog(@"%@======%@",date,data);

    if (success) {
//        NSLog(@"保存成功");
    }else
    {
//        NSLog(@"保存失败");
    }
}

+ (NSArray *)newsStatusWith:(NSString *)date index:(NSInteger)index
{
    // 1.查询数据
    FMResultSet *set = nil;
    // 返回前10条数据
    set = [_db executeQuery:@"SELECT * FROM share ORDER BY createTime DESC LIMIT 10"];
    // 2.取出数据
    NSMutableArray *models = [NSMutableArray array];
    
    while ([set next]) {
        // 2.1取出微博二进制数据
        NSData *data = [set objectForColumnName:@"dict"];
        //2.2将微博二进制数据转换为字典
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        // 2.3将字典转换为模型
        ZDShareModel *model = [ZDShareModel objectWithKeyValues:dict];
        ZDShareFrame *shareFrame = [[ZDShareFrame alloc] init];
        shareFrame.statesesModel = model;
        
        [models addObject:shareFrame];
    }
    
    return models;
}

+ (NSArray *)moreStatusWith:(NSString *)date index:(NSInteger)index
{
    // 1.查询数据
    FMResultSet *set = nil;
    // 返回前10条数据
    set = [_db executeQuery:@"SELECT * FROM share WHERE ? > createTime ORDER BY createTime DESC LIMIT 10",date];
    // SELECT TOP 页大小 *
//    FROM TestTable WHERE (ID NOT IN (SELECT TOP 页大小*页数 id FROM 表 ORDER BY id)) ORDER BY ID
    // 2.取出数据
    NSMutableArray *models = [NSMutableArray array];
    
    while ([set next]) {
        // 2.1取出微博二进制数据
        NSData *data = [set objectForColumnName:@"dict"];
        //2.2将微博二进制数据转换为字典
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        // 2.3将字典转换为模型
        ZDShareModel *model = [ZDShareModel objectWithKeyValues:dict];
        ZDShareFrame *shareFrame = [[ZDShareFrame alloc] init];
        shareFrame.statesesModel = model;
        
        [models addObject:shareFrame];
    }
    
    return models;
}



@end
