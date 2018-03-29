//
//  FMDBManager.h
//  FMDB 使用
//
//  Created by yinquan on 2018/3/29.
//  Copyright © 2018年 Closer. All rights reserved.
//

#import <FMDB/FMDB.h>

@class Student;
@interface FMDBManager : FMDatabase

+ (instancetype)shareInstance;

// 增
- (void)insertStudent:(Student *)student;
// 删 student 为空则删除全部
- (void)deleteStudent:(Student *)student;
// 改
- (void)updateStudent:(Student *)student newStudent:(Student *)newStudent;
// 查
- (NSArray *)queryStudent;

@end
