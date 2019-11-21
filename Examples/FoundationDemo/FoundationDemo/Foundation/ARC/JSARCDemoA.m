//
//  ARCDemo.m
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/9.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "JSARCDemoA.h"

@interface JSARCDemoA ()

@property (nonatomic, copy) void (^completion)(void);

@end

@implementation JSARCDemoA

- (void)testAssign {
    self.assignDemo = [[JSARCDemoA alloc] initWithTag:@"立即释放"];
    
    MCLogDebug(@"使用assign修饰对象，会在方法执行完成后立即释放,造成野指针");
}

- (void)testWeak {
    self.weakDemo = [[JSARCDemoA alloc] initWithTag:@"弱引用对象"];
}

- (void)testStrong {
    self.strongDemo = [[JSARCDemoA alloc] initWithTag:@"强引用对象"];
}

- (void)doSomething:(void (^)(void))block {
    _completion = block;
}

- (void)doNothing {
    if (_completion) {
        _completion();
    }
}

- (id)copyWithZone:(NSZone *)zone {
    //浅拷贝实现
    return self;
}

@end
