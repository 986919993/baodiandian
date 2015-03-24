//
//  ZDDataTool.m
//  IOSBaoDian
//
//  Created by Dong on 14-8-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDDataTool.h"
#import "FMDB.h"
#import "Singleton.h"

@interface ZDDataTool()
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic,assign) NSInteger zanshu;
@end
@implementation ZDDataTool
static FMDatabase *_db;
static FMDatabaseQueue *_queue;
static NSArray *_menus;
+ (void)initialize{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"shiti.sqlite"];
//    NSLog(@"====%@",fileName);
//    NSString *fileName = [[NSBundle mainBundle]pathForResource:@"shiti.sqlite" ofType:nil];
	// 1.获得数据库对象
    _db = [FMDatabase databaseWithPath:fileName];
    // 1.活的数据库队列对象
    _queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    // 2.在数据库队列中执行线程安全的操作
    [_queue inDatabase:^(FMDatabase *db) {
        if ([_db open]) {
            // 2.1创建表
            BOOL success =  [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_t (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT NOT NULL COLLATE NOCASE, detail TEXT NOT NULL, itemType TEXT NOT NULL, zan INTEGER NOT NULL);"];
            if (success) {
//                NSLog(@"创建表成功");
            }else
            {
//                NSLog(@"创建表失败");
            }
        }
    }];
//    [_queue inDatabase:^(FMDatabase *db) {
//        BOOL success = [db executeUpdate:@"DELETE FROM t_t WHERE 1;"];
//        if (success) {
//            NSLog(@"删除成功");
//        }else
//        {
//            NSLog(@"删除失败");
//        }
//    }];
    FMResultSet *set = [_db  executeQuery:@"SELECT * FROM t_t ORDER BY zan DESC LIMIT 200;"];
    // 2.取出数据
    if ([set next]) {
        return;
    }else{
        [_queue inDatabase:^(FMDatabase *db) {
            for (int i=0; i<=6; i++) {
                NSString *str = [NSString stringWithFormat:@"DataList%d.plist",i];
                NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
                _menus = [NSArray arrayWithContentsOfFile:path];
                for (NSDictionary *dict in _menus) {
                    NSString *title = dict[@"title"];
                    NSString *detail = dict[@"detail"];
                    NSString *itemType = dict[@"itemType"];
                    NSNumber *zan = dict[@"zan"];
                    [db executeUpdate:@"INSERT INTO t_t(title, detail,itemType,zan) VALUES(?,?,?,?)",title,detail,itemType,zan];
                }
            }
        }];
    }
}

+ (NSMutableArray *)dataWithSearch:(NSString *)text{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
        
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM t_t WHERE title like '%%%@%%' ORDER BY zan DESC LIMIT 200",text];
        FMResultSet *set = [_db executeQuery:sql];
        // 2.取出数据
        while ([set next]) {
            NSInteger dataID = [set intForColumn:@"id"];
            NSString *title = [set stringForColumn:@"title"];
            NSString *detail = [set stringForColumn:@"detail"];
            NSString *itemType = [set stringForColumn:@"itemType"];
            NSInteger zan = [set intForColumn:@"zan"];
            NSDictionary *dict = @{@"dataID":@(dataID),@"title":title,@"detail":detail,@"itemType":itemType,@"zan":@(zan)};
            [array addObject:dict];
        }
    }];
    return array;
}

+ (NSMutableArray *)dataWithItemType:(NSString *)itemType{

    NSMutableArray *array = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
        FMResultSet *set = [db  executeQuery:@"SELECT * FROM t_t WHERE itemType = ? ORDER BY zan DESC LIMIT 200",itemType];
        // 2.取出数据
        while ([set next]) {
            NSInteger dataID = [set intForColumn:@"id"];
            NSString *title = [set stringForColumn:@"title"];
            NSString *detail = [set stringForColumn:@"detail"];
            NSString *itemType = [set stringForColumn:@"itemType"];
            NSInteger zan = [set intForColumn:@"zan"];
            NSDictionary *dict = @{@"dataID":@(dataID),@"title":title,@"detail":detail,@"itemType":itemType,@"zan":@(zan)};
            [array addObject:dict];
        }
    }];
    return array;
}

+ (NSMutableArray *)dataList{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
        FMResultSet *set = [db  executeQuery:@"SELECT * FROM t_t ORDER BY zan DESC LIMIT 200;"];
        // 2.取出数据
        while ([set next]) {
            NSInteger dataID = [set intForColumn:@"id"];
            NSString *title = [set stringForColumn:@"title"];
            NSString *detail = [set stringForColumn:@"detail"];
            NSString *itemType = [set stringForColumn:@"itemType"];
            NSInteger zan = [set intForColumn:@"zan"];
            NSDictionary *dict = @{@"dataID":@(dataID),@"title":title,@"detail":detail,@"itemType":itemType,@"zan":@(zan)};
            [array addObject:dict];
        }
    }];
    return array;
}

+ (void)updata:(NSNumber *)dataID zan:(NSInteger)zan{
    if (zan < 99) {
        zan +=1;
    }
    [_db executeUpdate:@"UPDATE t_t SET zan = ? WHERE id = ?;",@(zan),dataID];
}
@end
