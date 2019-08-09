//
//  GCDDemo.h
//  iOSGuide
//
//  Created by joengzi on 2017/10/7.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TIRouterAction/TIRouterAction.h>

/**
 警告：在主队列中执行同步任务会造成Dead Lock
 线程：程序执行任务的最小调度单位
 任务：其实就是代码块，需要执行的内容
 队列：用来存放任务的数组
 */
@interface GCDDemo : NSObject

@property (nonatomic, copy) NSString *taskName;

+ (instancetype)demoWithName:(NSString *)taskName;

/**
 异步执行+并行队列
 */
+ (void)asyncConcurrent;

/**
 异步执行+串行队列
 */
+ (void)asyncSerial;

/**
 同步执行+并行队列
 */
+ (void)syncConcurrent;

/**
 同步执行+串行队列
 */
+ (void)syncSerial;

/**
 异步执行+主队列
 */
+ (void)asyncMain;

/**
 同步执行+主队列(Deadlock)
 */
+ (void)syncMain;

/**
 全局并行队列

 @param async 是否异步执行
 */
+ (void)gloabConcurrent:(BOOL)async;

/**
 分组任务

 @param serial 是否串行队列
 */
+ (void)dispatchGroup:(BOOL)serial;

/**
 屏蔽

 @param async 是否异步执行
 */
+ (void)dispatchBarrier:(BOOL)async;

/**
 信号量
 */
- (void)dispatchSemaphore:(BOOL)useSemap;

@end
