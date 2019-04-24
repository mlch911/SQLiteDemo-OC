//
//  SQLiteManager.m
//  SQLiteDemo
//
//  Created by mlch911 on 2019/4/24.
//  Copyright © 2019 mlch911. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>
#import <UIKit/UIKit.h>

@interface SQLiteManager () {
    sqlite3 *db;
}
@end

@implementation SQLiteManager

static SQLiteManager *instance;
+ (instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void) open {
    //document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //sqlite路径
    NSString *sqlitePath = [documentPath stringByAppendingPathComponent:@"database.sqlite"];
    //打开数据库
    int result = sqlite3_open(sqlitePath.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    } else {
        [self alertWithContent:@"打开数据库失败"];
        NSLog(@"%d", result);
    }
}

- (void) close {
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
    } else {
        [self alertWithContent:@"关闭数据库失败"];
        NSLog(@"%d", result);
    }
}

- (void)createTableWithName:(NSString *)tableName Keys:(NSString *)tableKeys {
    NSString * sqliteString = [[NSString alloc] initWithFormat:@"create table %@ (%@)", tableName, tableKeys];
//    NSLog(@"%@", sqliteString);
    char *error = nil;
    sqlite3_exec(db, sqliteString.UTF8String, nil, nil, &error);
    if (error == nil) {
        NSLog(@"创建表成功");
    } else {
        [self alertWithContent:@"创建表失败"];
        NSLog(@"%s", error);
    }
}

- (void) insertPersonWithName:(NSString *)name age:(int)age {
    NSString *sqliteString = [[NSString alloc] initWithFormat:@"insert into Person (name, age) values ('%@' ,%i)", name, age];
    char *error = nil;
    sqlite3_exec(db, sqliteString.UTF8String, nil, nil, &error);
    if (error == nil) {
        [self alertWithContent:@"插入表成功"];
//        NSLog(@"插入表成功");
    } else {
        [self alertWithContent:@"插入表失败"];
    }
}

- (void) select {
    NSString *sqliteString = @"select * from Person";
//    准备执行
    sqlite3_stmt *stmt = nil;
    sqlite3_prepare(db, sqliteString.UTF8String, -1, &stmt, nil);
//    单步执行
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        int ID = sqlite3_column_int(stmt, 0);
        const unsigned char *name = sqlite3_column_text(stmt, 1);
        NSString *nameString = [[NSString alloc] initWithUTF8String:(const char *)name];
        int age = sqlite3_column_int(stmt, 2);
        NSLog(@"id: %d name: %@ age: %d", ID, nameString, age);
    }
//    释放
    sqlite3_finalize(stmt);
}

- (void) alertWithContent: (NSString *) content {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"数据库执行结果" message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:alertController animated:YES completion:nil];
}

@end
