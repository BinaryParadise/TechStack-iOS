//
//  GCDDemo.m
//  iOSGuide
//
//  Created by joengzi on 2017/10/7.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "GCDActions.h"
#import <AddressBook/AddressBook.h>
#import <UIKit/UIKit.h>
#import "NSDictionary+ScriptNative.h"

@interface GCDActions ()

@property (nonatomic, strong) NSMutableArray *marr;
@property (nonatomic, strong) NSObject *object;

@end

@implementation GCDActions

- (instancetype)init
{
    self = [super init];
    if (self) {
        _marr = [NSMutableArray array];
    }
    return self;
}

+ (void)asyncConcurrent:(PGRouterContext *)context {
}

+ (void)asyncSerial:(PGRouterContext *)context {
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    //虽然是异步执行，由于是放入串行队列中将不会开启新线程
    dispatch_async(queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogDebug(@"任务2：%@（等待1秒)", [NSThread currentThread]);
        sleep(1);
    });
    dispatch_async(queue, ^{
        MCLogDebug(@"任务3：%@", [NSThread currentThread]);
        context.callback(YES, nil);
    });
}

+ (void)syncConcurrent:(PGRouterContext *)context {
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("并行队列标签", DISPATCH_QUEUE_CONCURRENT);
    
    MCLogInfo(@"-----------");
    
    //同步执行必须执行完后才能继续往下执行，不会开启新线程
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    MCLogInfo(@"-----------");
}

+ (void)syncSerial:(PGRouterContext *)context {
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("串行队列标签", DISPATCH_QUEUE_SERIAL);
    
    MCLogInfo(@"-----------");
    
    //同步执行必须执行完后才能继续往下执行，不会开启新线程
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    MCLogInfo(@"-----------");
}

+ (void)asyncMain:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    MCLogInfo(@"-----------");
    
    //任务1需要等待主线程有空执行，主线程要等syncMain执行完毕执行，造成Dead Lock
    dispatch_async(queue, ^{
        MCLogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    MCLogInfo(@"-----------");
}

+ (void)syncMain:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    MCLogInfo(@"-----------");
    
    //任务1需要等待主线程有空执行，主线程要等syncMain执行完毕执行，造成Deadlock
    //在主队列或者串行队列中执行同步任务会造成Deadlock
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    MCLogInfo(@"-----------");
}

+ (void)gloabConcurrent:(PGRouterContext *)context {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
}

+ (void)dispatchGroup:(PGRouterContext *)context {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("dispatchQueue", YES?DISPATCH_QUEUE_SERIAL:DISPATCH_QUEUE_CONCURRENT);
    
    MCLogInfo(@"-----------");
    
    //dispatch_group_async_f表示执行C语言函数
    dispatch_group_async(group, queue, ^{
        MCLogDebug(@"任务1：%@", [NSThread currentThread]);
        sleep(2);
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
    });
    
    MCLogInfo(@"-----------");
}

+ (void)dispatchBarrier:(PGRouterContext *)context {
    BOOL async = [context.config.parameters sn_boolForKey:@"async"];
    dispatch_queue_t queue = dispatch_queue_create("dispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    MCLogInfo(@"-----------");
    
    dispatch_barrier_async(queue, ^{
        MCLogWarn(@"开始：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        MCLogWarn(@"任务1：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        MCLogWarn(@"任务2：%@", [NSThread currentThread]);
    });
    
    //dispatch_barrier_async的任务只能单独执行，且只对并行队列有效
    //1、等待在它前面插入队列的任务先执行完
    //2、等待他们自己的任务执行完再执行后面的任务
    if (async) {
        //不会等待自己的任务结束，它会继续把后面的任务插入到队列，然后等待自己的任务结束后才执行后面任务。
        dispatch_barrier_async(queue, ^{
            sleep(2);
            MCLogWarn(@"单独任务：%@", [NSThread currentThread]);
        });
    }else {
        //需要等待自己的任务结束之后才会继续插入被写在它后面的任务，然后执行它们
        dispatch_barrier_sync(queue, ^{
            sleep(2);
            MCLogWarn(@"单独任务：%@", [NSThread currentThread]);
        });
    }
    
    dispatch_async(queue, ^{
        MCLogWarn(@"任务3：%@", [NSThread currentThread]);
    });
    
    MCLogInfo(@"-----------");
}

- (void)dispatchSemaphore:(PGRouterContext *)context {
    BOOL useSemap = [context.config.parameters sn_boolForKey:@"use"];
    
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
           [self.marr addObject:[GCDActions new]];
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
        
        MCLogInfo(@"循环耗时：%.3fs, %zd/%zd", [[NSDate date] timeIntervalSinceDate:date], self.marr.count, nmarr.count);
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
        MCLogInfo(@"修改耗时：%.3fs, %zd", [[NSDate date] timeIntervalSinceDate:date], self.marr.count);
    });
}

- (void)dealloc {
    MCLogWarn(@"");
}

@end
