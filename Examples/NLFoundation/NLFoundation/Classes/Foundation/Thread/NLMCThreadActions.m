//
//  MCThreadViewController.m
//  Neverland
//
//  Created by Rake Yang on 2019/2/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLMCThreadActions.h"
#import "NLRunLoopViewController.h"

@interface NLMCThreadActions ()

@end

@implementation NLMCThreadActions

+ (void)demo_NSThread:(PGRouterContext *)context {
    //休眠指定秒数
    [NSThread sleepForTimeInterval:0.2];
    
    //休眠到指定时间
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
    
    static NSThread *thread;
    if (!thread) {
        void(^threadBlock)(void) = ^() {
            [NSThread sleepForTimeInterval:2];//= sleep(2)
            NLLogDebug(@"执行任务 %@", [NSThread currentThread]);
            [context finished];
        };
        thread = [[NSThread alloc] initWithBlock:threadBlock];
        [thread start];
        //[NSThread detachNewThreadWithBlock:threadBlock];创建后立即执行
    }
    
    //当前线程
    NLLogDebug(@"当前线程 %@", [NSThread currentThread]);
}

+ (void)demo_GCD_main:(PGRouterContext *)context {
    printf("------------------GCD------------------\n");
    
    //主队列
    /*在主队列上执行同步任务造成DeadLock（互相等待）
    dispatch_sync(dispatch_get_main_queue(), ^{
        LogDebug(@"主队列同步任务1 %@", [NSThread currentThread])
    });*/
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NLLogDebug(@"主队列异步任务1 %@", [NSThread currentThread]);
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NLLogDebug(@"主队列异步任务2 %@", [NSThread currentThread]);
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NLLogDebug(@"主队列异步任务3 %@", [NSThread currentThread]);
    });
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //在全局队列queue上执行十次输出操作
    //该函数按指定的次数将指定的Block追加到指定的Dispatch Queue中，并等待全部处理执行结束，好处是可以重复执行某项操作并复用我们的Block了
    dispatch_apply(10, queue, ^(size_t index) {
        NLLogDebug(@"%zu", index);
    });
    
    [context finished];
}

+ (void)demo_GCD_serial:(PGRouterContext *)context {
    // 串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue1, ^{
        NLLogDebug(@"串行同步任务1 %@", [NSThread currentThread]);
    });
    dispatch_sync(queue1, ^{
        NLLogDebug(@"串行同步任务2 %@", [NSThread currentThread]);
    });
    dispatch_sync(queue1, ^{
        NLLogDebug(@"串行同步任务3 %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue1, ^{
        NLLogDebug(@"串行异步任务1 %@", [NSThread currentThread]);
    });
    dispatch_async(queue1, ^{
        NLLogDebug(@"串行异步任务2 %@", [NSThread currentThread]);
    });
    dispatch_async(queue1, ^{
        NLLogDebug(@"串行异步任务3 %@", [NSThread currentThread]);
    });
}

+ (void)demo_GCD_concurrent:(PGRouterContext *)context {
    // 并行队列
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue2, ^{
        NLLogDebug(@"并行-同步-1 %@", [NSThread currentThread]);
    });
    dispatch_sync(queue2, ^{
        NLLogDebug(@"并行-同步-2 %@", [NSThread currentThread]);
    });
    dispatch_sync(queue2, ^{
        NLLogDebug(@"并行-同步-3 %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue2, ^{
        NLLogDebug(@"并行-异步-1 %@", [NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        sleep(1);
        NLLogDebug(@"并行-异步-2 %@", [NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        NLLogDebug(@"并行-异步-3 %@", [NSThread currentThread]);
    });
    [context finished];
}

+ (void)demo_GCD_barrier:(PGRouterContext *)context {
    //栅栏
    dispatch_queue_t queue3 = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue3, ^{
        for (int i=0; i<3; i++) {
            NLLogDebug(@"并发-异步1-%d %@", i, [NSThread currentThread]);
        }
    });
    dispatch_async(queue3, ^{
        sleep(1);
        for (int i=0; i<3; i++) {
            NLLogDebug(@"并发-异步2-%d %@", i, [NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue3, ^{
        sleep(2);
        NLLogDebug(@"---------barrier---------%@", [NSThread currentThread]);
    });
    
    NLLogWarn(@"继续执行 %@", [NSThread currentThread]);
    
    dispatch_async(queue3, ^{
        sleep(1);
        for (int i=0; i<3; i++) {
            NLLogDebug(@"并发-异步3-%d %@", i, [NSThread currentThread]);
        }
        [context finished];
    });
    dispatch_async(queue3, ^{
        for (int i=0; i<3; i++) {
            NLLogDebug(@"并发-异步4-%d %@", i, [NSThread currentThread]);
        }
    });
}

/**
 分组任务

 @param context 上下文
 */
+ (void)demo_GCDGroup:(PGRouterContext *)context {
    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NLLogDebug(@"队列分组异步1 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NLLogDebug(@"队列分组异步2 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NLLogDebug(@"队列分组异步3 %@", [NSThread currentThread]);
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_enter(group);
        sleep(2);
        NLLogWarn(@"手动管理任务");
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NLLogDebug(@"全部完成 %@", [NSThread currentThread]);
        [context finished];
    });
}

+ (void)demo_NSOpertaion:(PGRouterContext *)context {
    NSBlockOperation *blockO = [NSBlockOperation blockOperationWithBlock:^{
        sleep(1);
        NLLogDebug(@"任务1完成 %@", [NSThread currentThread]);
        [context finished];
    }];
    
    NSBlockOperation *dependency = [NSBlockOperation blockOperationWithBlock:^{
        sleep(2);
        NLLogDebug(@"依赖任务 %@", [NSThread currentThread]);
    }];
    
    [blockO addDependency:dependency];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;//1：串行队列 -1：不限制 >1：限制
    [queue addOperation:blockO];
    [queue addOperation:dependency];
}

+ (void)demo_RunLoop:(PGRouterContext *)context {
    UIViewController *vc = [NLRunLoopViewController new];
    [self pushViewController:vc animated:YES];
    [context finished];
}

@end
