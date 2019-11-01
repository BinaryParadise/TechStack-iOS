//
//  MemoryConstruction.h
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/8.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 对象内存分布演示类
 */
@interface MemoryConstruction : NSObject

/**
 基本数据类型
 */
@property (nonatomic, assign) NSInteger number;

/**
 系统对象类型
 */
@property (nonatomic, copy) NSString *string;


/**
 方法
 */
- (void)testMethod:(NSInteger)number str:(NSString *)str;

@end
