//
//  SQLiteManager.h
//  SQLiteDemo
//
//  Created by mlch911 on 2019/4/24.
//  Copyright © 2019 mlch911. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQLiteManager : NSObject

//单例
+ (instancetype) shareInstance;
//打开数据库
- (void) open;
//关闭数据库
- (void) close;
//创建数据库
- (void) createTableWithName: (NSString*) tableName Keys: (NSString*) tableKeys;
//插入数据
- (void) insertPersonWithName: (NSString*) name age: (int) age;
//update、delete
//查询
- (void) select;




- (void) alertWithContent: (NSString *) content;

@end

NS_ASSUME_NONNULL_END
