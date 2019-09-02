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
@interface GCDActions : TIRouterActionBase

@property (nonatomic, copy) NSString *taskName;

/**
 异步执行+并行队列
 */
+ (void)asyncConcurrent:(PGRouterContext *)context PGTarget("fd://GCD/asyncConcurrent?c=异步并行队列");

/**
 异步执行+串行队列
 */
+ (void)asyncSerial:(PGRouterContext *)context PGTarget("fd://GCD/asyncSerial?c=异步串行队列");

/**
 同步执行+并行队列
 */
+ (void)syncConcurrent:(PGRouterContext *)context PGTarget("fd://GCD/syncConcurrent?c=同步并行队列");

/**
 同步执行+串行队列
 */
+ (void)syncSerial:(PGRouterContext *)context PGTarget("fd://GCD/syncConcurrent?c=同步并行队列");

/**
 异步执行+主队列
 */
+ (void)asyncMain:(PGRouterContext *)context PGTarget("fd://GCD/asyncMain?c=异步主队列");

/**
 同步执行+主队列(Deadlock)
 */
+ (void)syncMain:(PGRouterContext *)context PGTarget("fd://GCD/syncMain?c=同步主队列，会抛出Deadlock");

/**
 全局并行队列
 */
+ (void)gloabConcurrent:(PGRouterContext *)context PGTarget("fd://GCD/gloabConcurrent?c=全局异步并行队列");

/**
 分组任务

 @param serial 是否串行队列
 */
+ (void)dispatchGroup:(PGRouterContext *)context PGTarget("fd://GCD/gloabConcurrent?c=全局异步并行队列");

/**
 屏蔽

 @param async 是否异步执行
 */
+ (void)dispatchBarrier:(PGRouterContext *)context PGTarget("fd://GCD/dispatch_barrier?async=1&c=屏蔽栏栅");

/**
 信号量
 */
- (void)dispatchSemaphore:(PGRouterContext *)context PGTarget("fd://GCD/semaphore?c=信号量&use=1");

@end
