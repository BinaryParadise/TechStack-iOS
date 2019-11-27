//
//  GCDDemo.m
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/7.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "NLGCDActions.h"
#import <AddressBook/AddressBook.h>
#import <UIKit/UIKit.h>

@interface NLGCDActions ()

@property (nonatomic, strong) NSMutableArray *marr;
@property (nonatomic, strong) NSObject *object;

@end

@implementation NLGCDActions

- (instancetype)init
{
    self = [super init];
    if (self) {
        _marr = [NSMutableArray array];
    }
    return self;
}

+ (void)asyncConcurrent:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_queue_create("com.yuqi.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    MCLogInfo(@"创建并行队列: %@", queue);
    //异步执行将开启新线程
    dispatch_async(queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogDebug(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [context finished];
    });
}

+ (void)syncConcurrent:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_queue_create("com.yuqi.concurrent", DISPATCH_QUEUE_CONCURRENT);
    MCLogInfo(@"创建并行队列: %@", queue);
    //同步执行必须执行完后才能继续往下执行，不会开启新线程
    dispatch_sync(queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogDebug(@"任务2：%@", [NSThread currentThread]);
        sleep(3);
    });
    dispatch_sync(queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [context finished];
    });
}

+ (void)asyncSerial:(PGRouterContext *)context {
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    //虽然是异步执行，由于是放入串行队列中将不会开启新线程
    dispatch_async(queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(1);
        MCLogDebug(@"任务2：%@（等待1秒)", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogVerbose(@"完成");
        [context finished];
    });
}

+ (void)syncSerial:(PGRouterContext *)context {
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("串行队列标签", DISPATCH_QUEUE_SERIAL);
    
    //同步执行必须执行完后才能继续往下执行，不会开启新线程
    dispatch_sync(queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        sleep(5);
        MCLogDebug(@"任务2：%@ sleep(5)", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [context finished];
    });
}

+ (void)asyncMain:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //需要等待任务1执行完成，造成UI阻塞
    dispatch_async(queue, ^{
        MCLogWarn(@"任务1：%@ sleep(5)", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(5);
        MCLogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [context finished];
    });
}

+ (void)syncMain:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //任务1需要等待主线程有空执行，主线程要等syncMain执行完毕执行，造成Deadlock
    //在主队列或者串行队列中执行同步任务会造成Deadlock
    dispatch_sync(queue, ^{
        sleep(1);
        MCLogWarn(@"任务1：%@ sleep(1)", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [context finished];
    });
}

+ (void)asyncGloabConcurrent:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogDebug(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [context finished];
    });
}

+ (void)syncGloabConcurrent:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogDebug(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [context finished];
    });
}

+ (void)asyncGroup:(PGRouterContext *)context {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("dispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //dispatch_group_async_f表示执行C语言函数
    dispatch_group_async(group, queue, ^{
        sleep(2);
        MCLogDebug(@"任务1：%@ sleep(2)", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        MCLogDebug(@"任务2：%@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
    });
    
    //dispatch_group_notify_f表示执行C语言函数
    dispatch_group_notify(group, queue, ^{
        MCLogWarn(@"执行完成：%@", [NSThread currentThread]);
        [context finished];
    });
}

+ (void)asyncGroupSerial:(PGRouterContext *)context {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("dispatchQueue", DISPATCH_QUEUE_SERIAL);
    
    //dispatch_group_async_f表示执行C语言函数
    dispatch_group_async(group, queue, ^{
        sleep(2);
        MCLogDebug(@"任务1：%@ sleep(2)", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        MCLogDebug(@"任务2：%@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
    });
    
    //dispatch_group_notify_f表示执行C语言函数
    dispatch_group_notify(group, queue, ^{
        MCLogDebug(@"执行完成：%@", [NSThread currentThread]);
        [context finished];
    });
}

+ (void)asyncBarrier:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_queue_create("dispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        sleep(5);
        MCLogDebug(@"任务1：%@ sleep(5)", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        MCLogDebug(@"任务2：%@", [NSThread currentThread]);
    });
    
    //dispatch_barrier_async的任务只能单独执行，且只对并行队列有效
    //1、等待在它前面插入队列的任务先执行完
    //2、不会等待自己的任务结束，它会继续把后面的任务插入到队列，然后等待自己的任务结束后才执行后面任务。
    dispatch_barrier_async(queue, ^{
        sleep(2);
        MCLogWarn(@"插入任务：%@", [NSThread currentThread]);
    });
    
    MCLogVerbose(@"继续加入任务");
    
    dispatch_async(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        [context finished];
    });
}

+ (void)syncBarrier:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_queue_create("dispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_barrier_async(queue, ^{
        MCLogDebug(@"开始：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        sleep(5);
        MCLogDebug(@"任务1：%@ sleep(5)", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        MCLogDebug(@"任务2：%@", [NSThread currentThread]);
    });
    
    //dispatch_barrier_async的任务只能单独执行，且只对并行队列有效
    //1、等待在它前面插入队列的任务先执行完
    //2、需要等待自己的任务结束之后才会继续插入被后面的任务，然后执行
    dispatch_barrier_sync(queue, ^{
        sleep(2);
        MCLogWarn(@"插入任务：%@", [NSThread currentThread]);
    });
    
    MCLogVerbose(@"继续加入任务");
    
    dispatch_async(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        [context finished];
    });
}

+ (void)dispatchSemaphore:(PGRouterContext *)context {
    BOOL useSemap = [context.config.parameters mc_boolForKey:@"use"];
    
    NSMutableArray *marr = [NSMutableArray array];
    
    /*
     通过dispatch_semaphore_create 函数创建一个Semaphore并初始化信号的总量。
     通过dispatch_semaphore_signal 函数发送一个信号，让信号总量加1。
     通过dispatch_semaphore_wait可以使总信号量减1，当信号总量为0时就会一直等待，否则就可以正常执行
     */
    dispatch_semaphore_t semaphore;
    if (useSemap) {
        semaphore = dispatch_semaphore_create(1);
    }
    
    dispatch_queue_t queue = dispatch_queue_create("arraySafeQueue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i=0; i<2000000; i++) {
        [marr addObject:[NLGCDActions new]];
    }
    dispatch_async(queue, ^{
        NSDate *date = [NSDate date];
        if (useSemap) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        
        //添加比较耗时，在此期间异步移除了一个元素，所以导致导致crash
        //*** -[GCDDemo retain]: message sent to deallocated instance 0x608002c142d0
        NSMutableArray *nmarr = [NSMutableArray array];
        //除了使用信号量也可以使用copy的后的数组，这样不会被异步改变
        [nmarr addObjectsFromArray:marr];
        
        MCLogDebug(@"循环耗时：%.3fs, %zd/%zd", [[NSDate date] timeIntervalSinceDate:date], marr.count, nmarr.count);
        if (useSemap) {
            dispatch_semaphore_signal(semaphore);
        }
    });
    dispatch_async(queue, ^{
        NSDate *date = [NSDate date];
        if (useSemap) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }else {
            [NSThread sleepForTimeInterval:0.05];
        }
        
        //增加不会导致crash
        //[marr addObject:@(1000001)];
        //会导致崩溃，316行开始添加到数组时的元素为200万个，但是添加过程中移除了一个，添加最后一个原始是会触发对象已释放的异常
        //self.object = [self.marr lastObject];
        [marr removeLastObject];
        
        if (useSemap) {
            dispatch_semaphore_signal(semaphore);
        }
        MCLogDebug(@"修改耗时：%.3fs, %zd", [[NSDate date] timeIntervalSinceDate:date], marr.count);
    });
    
    dispatch_barrier_async(queue, ^{
        [context finished];
    });
}

+ (void)notSemaphore:(PGRouterContext *)context {
    [self dispatchSemaphore:context];
}

@end
