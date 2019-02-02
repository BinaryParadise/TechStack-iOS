//
//  ARCDemo.h
//  iOSGuide
//
//  Created by joengzi on 2017/10/9.
//  Copyright © 2017年 joenggaa. All rights reserved.
//

#import <Foundation/Foundation.h>

//自动内存管理演示
@interface ARCDemo : NSObject<NSCopying>

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) ARCDemo *assignDemo;
@property (nonatomic, weak) ARCDemo *weakDemo;

- (instancetype)initWithNumber:(NSInteger)number;

- (void)testAssign;
- (void)testWeak;

@end
