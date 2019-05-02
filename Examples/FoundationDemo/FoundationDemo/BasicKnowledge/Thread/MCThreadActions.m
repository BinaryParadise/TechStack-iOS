//
//  MCThreadViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/2/24.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "MCThreadActions.h"

@interface MCThreadActions ()

@end

@implementation MCThreadActions

- (void)demo_NSThread {
    printf("------------------NSThread------------------\n");
    //手动启动
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1:) object:@"thread1"];
    [thread1 start];
    
    //自动启动
    [NSThread detachNewThreadSelector:@selector(doSomething2:) toTarget:self withObject:@"thread2"];
    
    //隐式创建，直接启动
    [self performSelectorInBackground:@selector(doSomething3:) withObject:@"thread3"];
    
    //休眠指定秒数
    [NSThread sleepForTimeInterval:0.2];
    
    //休眠到指定时间
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    
    //当前线程
    MCLogDebug(@"当前线程 %@", [NSThread currentThread])
}

- (void)demo_GCD {
    printf("------------------GCD------------------\n");
    
    //主队列
    /*在主队列上执行同步任务造成DeadLock
    dispatch_sync(dispatch_get_main_queue(), ^{
        LogDebug(@"主队列同步任务1 %@", [NSThread currentThread])
    });*/
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MCLogDebug(@"主队列异步任务1 %@", [NSThread currentThread])
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        MCLogDebug(@"主队列异步任务2 %@", [NSThread currentThread])
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        MCLogDebug(@"主队列异步任务3 %@", [NSThread currentThread])
    });
    
    // 串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue1, ^{
       MCLogDebug(@"串行同步任务1 %@", [NSThread currentThread])
    });
    dispatch_sync(queue1, ^{
        MCLogDebug(@"串行同步任务2 %@", [NSThread currentThread])
    });
    dispatch_sync(queue1, ^{
        MCLogDebug(@"串行同步任务3 %@", [NSThread currentThread])
    });
    
    dispatch_async(queue1, ^{
        MCLogDebug(@"串行异步任务1 %@", [NSThread currentThread])
    });
    dispatch_async(queue1, ^{
        MCLogDebug(@"串行异步任务2 %@", [NSThread currentThread])
    });
    dispatch_async(queue1, ^{
        MCLogDebug(@"串行异步任务3 %@", [NSThread currentThread])
    });
    
    // 并行队列
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue2, ^{
        MCLogDebug(@"并行同步任务1 %@", [NSThread currentThread])
    });
    dispatch_sync(queue2, ^{
        MCLogDebug(@"并行同步任务2 %@", [NSThread currentThread])
    });
    dispatch_sync(queue2, ^{
        MCLogDebug(@"并行同步任务3 %@", [NSThread currentThread])
    });
    
    dispatch_async(queue2, ^{
        MCLogDebug(@"并行异步任务1 %@", [NSThread currentThread])
    });
    dispatch_async(queue2, ^{
        MCLogDebug(@"并行异步任务2 %@", [NSThread currentThread])
    });
    dispatch_async(queue2, ^{
        MCLogDebug(@"并行异步任务3 %@", [NSThread currentThread])
    });
    
    //栅栏
    dispatch_queue_t queue3 = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue3, ^{
        for (int i=0; i<3; i++) {
            MCLogDebug(@"栅栏并发异步1-%d %@", i, [NSThread currentThread]);
        }
    });
    dispatch_async(queue3, ^{
        for (int i=0; i<3; i++) {
            MCLogDebug(@"栅栏并发异步2-%d %@", i, [NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue3, ^{
        MCLogDebug(@"---------barrier---------%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue3, ^{
        for (int i=0; i<3; i++) {
            MCLogDebug(@"栅栏并发异步3-%d %@", i, [NSThread currentThread]);
        }
    });
    dispatch_async(queue3, ^{
        for (int i=0; i<3; i++) {
            MCLogDebug(@"栅栏并发异步4-%d %@", i, [NSThread currentThread]);
        }
    });
    
    //队列分组
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        MCLogDebug(@"队列分组异步1 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        MCLogDebug(@"队列分组异步2 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        MCLogDebug(@"队列分组异步3 %@", [NSThread currentThread]);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        MCLogDebug(@"队列分组任务全部执行完成 %@", [NSThread currentThread]);
    });
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //在全局队列queue上执行十次输出操作
    dispatch_apply(10, queue, ^(size_t index) {
        MCLogDebug(@"%zu", index);
    });
    
    MCLogDebug(@"done!");
}

- (void)demo_NSOperation {
    printf("------------------NSOperation------------------\n");
}

- (void)doSomething1:(id)sender {
    MCLogDebug(@"随便做些事情1 %@", sender);
}

- (void)doSomething2:(id)sender {
    MCLogDebug(@"随便做些事情2 %@", sender);
}

- (void)doSomething3:(id)sender {
    MCLogDebug(@"随便做些事情3 %@", sender);
}

@end
