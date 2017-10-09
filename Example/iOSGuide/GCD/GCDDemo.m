//
//  GCDDemo.m
//  iOSGuide
//
//  Created by mylcode on 2017/10/7.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import "GCDDemo.h"
#import <AddressBook/AddressBook.h>
#import <UIKit/UIKit.h>

@interface GCDDemo ()

@property (nonatomic, strong) NSMutableArray *marr;
@property (nonatomic, strong) NSObject *object;

@end

@implementation GCDDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _marr = [NSMutableArray array];
    }
    return self;
}

+ (void)asyncConcurrent {
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
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
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
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
    dispatch_queue_t queue = dispatch_queue_create("串行队列标签", DISPATCH_QUEUE_SERIAL);
    
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

+ (void)asyncMain {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    LogInfo(@"-----------");
    
    //任务1需要等待主线程有空执行，主线程要等syncMain执行完毕执行，造成Dead Lock
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

+ (void)syncMain {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    LogInfo(@"-----------");
    
    //任务1需要等待主线程有空执行，主线程要等syncMain执行完毕执行，造成Deadlock
    //在主队列或者串行队列中执行同步任务会造成Deadlock
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

+ (void)gloabConcurrent:(BOOL)async {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    LogInfo(@"-----------");
    
    if (async) {
        dispatch_async(queue, ^{
            LogWarn(@"任务1：%@", [NSThread currentThread]);
        });
        dispatch_async(queue, ^{
            LogWarn(@"任务2：%@", [NSThread currentThread]);
        });
        dispatch_async(queue, ^{
            LogWarn(@"任务3：%@", [NSThread currentThread]);
        });
    }else {
        dispatch_sync(queue, ^{
            LogWarn(@"任务1：%@", [NSThread currentThread]);
        });
        dispatch_sync(queue, ^{
            LogWarn(@"任务2：%@", [NSThread currentThread]);
        });
        dispatch_sync(queue, ^{
            LogWarn(@"任务3：%@", [NSThread currentThread]);
        });
    }
    
    LogInfo(@"-----------");
}

+ (void)dispatchGroup:(BOOL)serial {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("dispatchQueue", serial?DISPATCH_QUEUE_SERIAL:DISPATCH_QUEUE_CONCURRENT);
    
    LogInfo(@"-----------");
    
    //dispatch_group_async_f表示执行C语言函数
    dispatch_group_async(group, queue, ^{
        LogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        LogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        LogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    //dispatch_group_notify_f表示执行C语言函数
    dispatch_group_notify(group, queue, ^{
        LogWarn(@"执行完成：%@", [NSThread currentThread]);
    });
    
    LogInfo(@"-----------");
}

+ (void)dispatchBarrier:(BOOL)async {
    dispatch_queue_t queue = dispatch_queue_create("dispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    LogInfo(@"-----------");
    
    dispatch_barrier_async(queue, ^{
        LogWarn(@"开始：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        LogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        LogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    
    //dispatch_barrier_async的任务只能单独执行，且只对并行队列有效
    //1、等待在它前面插入队列的任务先执行完
    //2、等待他们自己的任务执行完再执行后面的任务
    if (async) {
        //不会等待自己的任务结束，它会继续把后面的任务插入到队列，然后等待自己的任务结束后才执行后面任务。
        dispatch_barrier_async(queue, ^{
            sleep(2);
            LogWarn(@"单独任务：%@", [NSThread currentThread]);
        });
    }else {
        //需要等待自己的任务结束之后才会继续插入被写在它后面的任务，然后执行它们
        dispatch_barrier_sync(queue, ^{
            sleep(2);
            LogWarn(@"单独任务：%@", [NSThread currentThread]);
        });
    }
    
    dispatch_async(queue, ^{
        LogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    LogInfo(@"-----------");
}

- (void)dispatchSemaphore:(BOOL)useSemap {
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
           [self.marr addObject:[GCDDemo new]];
    }
    dispatch_async(queue, ^{
        NSDate *date = [NSDate date];
        if (useSemap) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        
        //这里导致crash
        //*** -[GCDDemo retain]: message sent to deallocated instance 0x608002c142d0
        NSMutableArray *nmarr = [NSMutableArray array];
        [nmarr addObjectsFromArray:self.marr];
        
        LogInfo(@"循环耗时：%.3fs, %zd/%zd", [[NSDate date] timeIntervalSinceDate:date], self.marr.count, nmarr.count);
        if (useSemap) {
            dispatch_semaphore_signal(semaphore);
        }
    });
    dispatch_async(queue, ^{
        NSDate *date = [NSDate date];
        if (useSemap) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }else {
            [NSThread sleepForTimeInterval:0.1];
        }
        
        //增加不会导致crash
        //[marr addObject:@(1000001)];
        //会导致崩溃，275行开始添加到数组时的元素为200万个，但是添加过程中移除了一个，添加最后一个原始是会触发对象已释放的异常
        //self.object = [self.marr lastObject];
        [self.marr removeLastObject];
        
        if (useSemap) {
            dispatch_semaphore_signal(semaphore);
        }
        LogInfo(@"修改耗时：%.3fs, %zd", [[NSDate date] timeIntervalSinceDate:date], self.marr.count);
    });
}

- (void)dealloc {
    LogWarn(@"");
}

@end
