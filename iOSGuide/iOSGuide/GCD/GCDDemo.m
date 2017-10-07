//
//  GCDDemo.m
//  iOSGuide
//
//  Created by mylcode on 2017/10/7.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "GCDDemo.h"

@implementation GCDDemo

+ (void)asyncConcurrent {
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("并行队列标签", DISPATCH_QUEUE_CONCURRENT);
    
    LogInfo(@"-----------");
    
    //异步执行将开启新线程
    dispatch_async(queue, ^{
        LogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        LogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        LogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    LogInfo(@"-----------");
}

+ (void)asyncSerial {
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("并行队列标签", DISPATCH_QUEUE_SERIAL);
    
    LogInfo(@"-----------");
    
    //虽然是异步执行，由于是放入串行队列中将不会开启新线程
    dispatch_async(queue, ^{
        LogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        LogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        LogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    LogInfo(@"-----------");
}

+ (void)syncConcurrent {
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("并行队列标签", DISPATCH_QUEUE_CONCURRENT);
    
    LogInfo(@"-----------");
    
    //同步执行必须执行完后才能继续往下执行，不会开启新线程
    dispatch_sync(queue, ^{
        LogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        LogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        LogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    LogInfo(@"-----------");
}

+ (void)syncSerial {
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("并行队列标签", DISPATCH_QUEUE_SERIAL);
    
    LogInfo(@"-----------");
    
    //同步执行必须执行完后才能继续往下执行，不会开启新线程
    dispatch_sync(queue, ^{
        LogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        LogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        LogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    LogInfo(@"-----------");
}

+ (void)syncMain {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    LogInfo(@"-----------");
    
    //任务1需要等待主线程有空执行，主线程要等syncMain执行完毕执行，造成Dead Lock
    dispatch_sync(queue, ^{
        LogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        LogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        LogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    LogInfo(@"-----------");
}

@end
