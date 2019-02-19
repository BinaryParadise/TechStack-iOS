//
//  ARCDemo.m
//  iOSGuide
//
//  Created by joengzi on 2017/10/9.
//  Copyright © 2017年 joenggaa. All rights reserved.
//

#import "JSARCDemoA.h"

@implementation JSARCDemoA

- (instancetype)initWithNumber:(NSInteger)number {
    if (self = [super init]) {
        _number = number;
    }
    return self;
}

- (void)testAssign {
    self.assignDemo = [[JSARCDemoA alloc] initWithNumber:99];
    
    LogWarn(@"使用assign修饰对象，会在方法执行完成后立即释放,造成野指针");
}

- (void)testWeak {
    self.weakDemo = [[JSARCDemoA alloc] initWithNumber:9];
}

- (id)copyWithZone:(NSZone *)zone {
    //浅拷贝实现
    return self;
}

- (void)dealloc {
    LogInfo(@"%ld", self.number);
}

@end
