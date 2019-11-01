//
//  ARCDemo.h
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/9.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "JSModel.h"

//自动内存管理演示
@interface JSARCDemoA : JSModel<NSCopying>

@property (nonatomic, assign) JSARCDemoA *assignDemo;
@property (nonatomic, weak) JSARCDemoA *weakDemo;
@property (nonatomic, weak) id demoB;

- (void)testAssign;
- (void)testWeak;

- (void)doSomething:(void (^)(void))block;
- (void)doNothing;

@end
