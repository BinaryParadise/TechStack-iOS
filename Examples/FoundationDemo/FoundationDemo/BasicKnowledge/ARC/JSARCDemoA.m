//
//  ARCDemo.m
//  iOSGuide
//
//  Created by joengzi on 2017/10/9.
//  Copyright © 2017年 joenggaa. All rights reserved.
//

#import "JSARCDemoA.h"

@implementation JSARCDemoA

- (void)testAssign {
    self.assignDemo = [[JSARCDemoA alloc] initWithTag:@"立即释放"];
    
    LogWarn(@"使用assign修饰对象，会在方法执行完成后立即释放,造成野指针");
}

- (void)testWeak {
    self.weakDemo = [[JSARCDemoA alloc] initWithTag:@"弱引用对象"];
}

- (void)doSomething:(void (^)(void))block {
    if (block) {
        //block();
    }
}

- (void)doNothing {
    
}

- (id)copyWithZone:(NSZone *)zone {
    //浅拷贝实现
    return self;
}

@end
