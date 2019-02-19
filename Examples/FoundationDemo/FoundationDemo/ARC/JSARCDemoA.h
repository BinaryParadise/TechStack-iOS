//
//  ARCDemo.h
//  iOSGuide
//
//  Created by joengzi on 2017/10/9.
//  Copyright © 2017年 joenggaa. All rights reserved.
//

#import <Foundation/Foundation.h>

//自动内存管理演示
@interface JSARCDemoA : NSObject<NSCopying>

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) JSARCDemoA *assignDemo;
@property (nonatomic, weak) JSARCDemoA *weakDemo;
@property (nonatomic, strong) id demoB;

- (instancetype)initWithNumber:(NSInteger)number;

- (void)testAssign;
- (void)testWeak;

@end
