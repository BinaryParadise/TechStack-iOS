//
//  ARCDemo.m
//  iOSGuide
//
//  Created by odyang on 2017/10/9.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "ARCDemo.h"

@implementation ARCDemo

- (void)testAssign {
    self.number = 19999;
    self.assignDemo = [ARCDemo new];
    
    LogWarn(@"使用assign修饰对象，会在方法执行完成后立即释放,造成野指针");
}

- (id)copyWithZone:(NSZone *)zone {
    //浅拷贝实现
    return self;
}

- (void)dealloc {
    LogInfo(@"");
}

@end
