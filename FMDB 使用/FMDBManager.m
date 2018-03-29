//
//  FMDBManager.m
//  FMDB 使用
//
//  Created by yinquan on 2018/3/29.
//  Copyright © 2018年 Closer. All rights reserved.
//

#import "FMDBManager.h"
#import "Student.h"

@implementation FMDBManager

+ (instancetype)shareInstance {
    static FMDBManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *dbPath = [path stringByAppendingPathComponent:@"test.db"];
        instance = [self databaseWithPath:dbPath];
        
        if([instance open]) {
            BOOL isSuccess = [instance executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INT NOT NULL);"];
            if (isSuccess) {
                NSLog(@"建表成功");
            } else {
                NSLog(@"建表失败");
            }
            [instance close];
        } else {
            NSLog(@"打开数据库失败");
        }
    });
    return instance;
}

- (void)insertStudent:(Student *)student {
    if ([self open]) {
        BOOL isSuccess = [self executeUpdate:@"INSERT INTO t_student(NAME, AGE) VALUES(?, ?);", student.name, @(student.age)];
        if (isSuccess) {
            NSLog(@"插入数据成功");
        } else {
            NSLog(@"插入数据失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)deleteStudent:(Student *)student {
    if ([self open]) {
        BOOL isSuccess = NO;
        if (student) {
            isSuccess = [self executeUpdate:@"DELETE FROM t_student WHERE NAME = ? AND AGE = ?", student.name, @(student.age)];
        } else {
            isSuccess = [self executeUpdate:@"DELETE FROM t_student;"];
        }
        if (isSuccess) {
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)updateStudent:(Student *)student newStudent:(Student *)newStudent {
    if ([self open]) {
        BOOL isSuccess = [self executeUpdate:@"UPDATE t_student SET NAME = ?, AGE = ? WHERE NAME = ? AND AGE = ?", newStudent.name, @(newStudent.age), student.name, @(student.age)];
        if (isSuccess) {
            NSLog(@"更新数据成功");
        } else {
            NSLog(@"更新数据失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (NSArray *)queryStudent {
    NSMutableArray *mArray = [NSMutableArray array];
    if ([self open]) {
        FMResultSet *set = [self executeQuery:@"SELECT * FROM t_student"];
        while ([set next]) {
            Student *student = [[Student alloc] init];
            student.name = [set stringForColumn:@"name"];
            student.age = [set intForColumn:@"age"];
            [mArray addObject:student];
        }
    } else {
        NSLog(@"打开数据库失败");
    }
    return [mArray copy];
}



@end
