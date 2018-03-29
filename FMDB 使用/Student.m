//
//  Student.m
//  FMDB 使用
//
//  Created by yinquan on 2018/3/29.
//  Copyright © 2018年 Closer. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@, %ld>", [self class], self, self.name, self.age];
}

@end
