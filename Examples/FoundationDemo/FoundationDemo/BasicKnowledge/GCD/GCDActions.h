//
//  GCDDemo.h
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/7.
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
+ (void)asyncConcurrent:(PGRouterContext *)context PGTarget("fd://GCD/Concurrent/async?c=异步:新线程执行，执行顺序不确定");

/**
 同步执行+并行队列
 */
+ (void)syncConcurrent:(PGRouterContext *)context PGTarget("fd://GCD/Concurrent/sync?c=同步:主线程执行，按加入的先后顺序执行");

/**
 异步执行+串行队列
 */
+ (void)asyncSerial:(PGRouterContext *)context PGTarget("fd://GCD/Serial/async?c=异步:开启新线程，按顺序执行");

/**
 同步执行+串行队列
 */
+ (void)syncSerial:(PGRouterContext *)context PGTarget("fd://GCD/Serial/sync?c=同步:主线程执行，按顺序执行");

/**
 异步执行+主队列
 */
+ (void)asyncMain:(PGRouterContext *)context PGTarget("fd://GCD/Main/async?c=异步:按顺序执行，耗时任务会造成阻塞");

/**
 同步执行+主队列(Deadlock)
 */
+ (void)syncMain:(PGRouterContext *)context PGTarget("fd://GCD/Main/syncMain?c=🔞同步:互相等待造成死锁，抛出异常EXC_BAD_INSTRUCTION");

/**
 全局并行队列:异步
 */
+ (void)asyncGloabConcurrent:(PGRouterContext *)context PGTarget("fd://GCD/GlobalConcurrent/async?c=异步:新线程执行，顺序不确定（合适执行由优先级确定）");

/**
 全局并行队列:同步
 */
+ (void)syncGloabConcurrent:(PGRouterContext *)context PGTarget("fd://GCD/GlobalConcurrent/sync?c=同步:主线程执行，按顺序执行");

/**
 分组任务
 */
+ (void)asyncGroup:(PGRouterContext *)context PGTarget("fd://GCD/Group/concurrent?c=异步:并行队列新线程，顺序不确定，完成后通知");

/**
 分组任务
 */
+ (void)asyncGroupSerial:(PGRouterContext *)context PGTarget("fd://GCD/Group/serial?c=异步:串行队列新线程，按顺序执行，完成后通知");

/**
 屏蔽
 */
+ (void)asyncBarrier:(PGRouterContext *)context PGTarget("fd://GCD/Barrier/async?c=【并行队列】不等待插入任务完成继续加入任务");

+ (void)syncBarrier:(PGRouterContext *)context PGTarget("fd://GCD/Barrier/sync?c=【并行队列】等待插入任务执行完成后继续加入任务");

/**
 信号量
 */
+ (void)dispatchSemaphore:(PGRouterContext *)context PGTarget("fd://GCD/Semaphore/create?c=使用信号量&use=1");

+ (void)notSemaphore:(PGRouterContext *)context PGTarget("fd://GCD/Semaphore/normal?c=🔞不使用，会导致异常&use=0");

@end
