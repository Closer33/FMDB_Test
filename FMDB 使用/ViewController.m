//
//  ViewController.m
//  FMDB 使用
//
//  Created by yinquan on 2018/3/29.
//  Copyright © 2018年 Closer. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
#include "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self update];
}

- (void)insert {
    Student *student = [[Student alloc] init];
    student.name = @"Closer";
    student.age = 23;
    [[FMDBManager shareInstance] insertStudent:student];
    NSLog(@"%@", [self query]);
}

- (void)delete {
    Student *student = [[Student alloc] init];
    student.name = @"Closer";
    student.age = 23;
    [[FMDBManager shareInstance] deleteStudent:student];
    NSLog(@"%@", [self query]);
}

- (void)update {
    Student *student = [[Student alloc] init];
    student.name = @"Closer";
    student.age = 23;
    [[FMDBManager shareInstance] insertStudent:student];
    NSLog(@"%@", [self query]);
    Student *newStudent = [[Student alloc] init];
    newStudent.name = @"Bob";
    newStudent.age = 17;
    [[FMDBManager shareInstance] updateStudent:student newStudent:newStudent];
    NSLog(@"%@", [self query]);
}

- (NSArray *)query {
    return [[FMDBManager shareInstance] queryStudent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
