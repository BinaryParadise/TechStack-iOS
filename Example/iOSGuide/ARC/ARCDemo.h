//
//  ARCDemo.h
//  iOSGuide
//
//  Created by odyang on 2017/10/9.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import <Foundation/Foundation.h>

//自动内存管理演示
@interface ARCDemo : NSObject<NSCopying>

@property (nonatomic, assign) int number;
@property (nonatomic, assign) ARCDemo *assignDemo;

- (void)testAssign;

@end
