//
//  MCLockTableViewController.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/28.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NLMCLockActions.h"
#import <libkern/OSAtomic.h>
#include <pthread/pthread.h>
#include <os/lock.h>

static NSUInteger _count;
static pthread_mutex_t _mutex;

@interface NLMCLockActions () {
}

@property (nonatomic, copy) NSDictionary<NSNumber *, NSString *> *actionsDict;

@property NSMutableArray *marr;

@end

@implementation NLMCLockActions

+ (void)load {
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);
    pthread_mutex_init(&_mutex, &attr);//创建锁
}

+ (void)trigger_DeadLock:(PGRouterContext *)context {
    static NSLock *lock;
    if (!lock) {
        lock = [[NSLock alloc] init];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        static void (^RecursiveMethod)(int);
        
        RecursiveMethod = ^(int value) {
            
            [lock lock];
            if (value > 0) {
                
                NLLogDebug(@"value = %d", value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
        };
        
        RecursiveMethod(5);
    });
    [context finished];
}

+ (void)go_OSSpinLock:(PGRouterContext *)context {
    static OSSpinLock oslock = OS_SPINLOCK_INIT;
    /**
     适用于等待队列任务
     0表示可以上锁
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if(OSSpinLockTry(&oslock)) {
            NLLogDebug(@"%@ 上锁%d", [NSThread currentThread], oslock);
            sleep(3);
            NLLogDebug(@"%@ 恢复%d", [NSThread currentThread], oslock);
            OSSpinLockUnlock(&oslock);
            NLLogDebug(@"%@ 解锁%d", [NSThread currentThread], oslock);
        } else {
            NLLogWarn(@"%@ 锁住了", [NSThread currentThread]);
        }
    });
    [context finished];
}

+ (void)go_OSUnfairLock:(PGRouterContext *)context {
    static os_unfair_lock uflock = OS_UNFAIR_LOCK_INIT;
    NLLogVerbose(@"%p", &uflock);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        if(os_unfair_lock_trylock(&uflock)) {
        os_unfair_lock_lock(&uflock);//解锁后继续执行
            NLLogDebug(@"%@ 上锁", [NSThread currentThread]);
            sleep(3);
            os_unfair_lock_unlock(&uflock);
            NLLogDebug(@"%@ 解锁", [NSThread currentThread]);
//        }
        NLLogWarn(@"线程即将结束");
    });
    [context finished];
}

+ (void)go_semaphore:(PGRouterContext *)context {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //传入值必须 >0, 若传入为0则阻塞线程并等待timeout,时间到后会执行其后的语句
    dispatch_queue_t queue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(1);
        long ret = dispatch_semaphore_signal(semaphore);
        NLLogDebug(@"准备完成，发送信号，当前等待=%ld", ret);
    });
    dispatch_async(queue, ^{
        long ret = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        sleep(3);
        NLLogDebug(@"任务1完成 %@, %d", [NSThread currentThread], ret);
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(queue, ^{
        //此刻信号量为0，线程阻塞等待信号唤起，超时时间2秒
        long ret = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC));
        if (ret == 0) {//分支处理
            //收到信号，继续执行
            NLLogDebug(@"任务2完成 %@", [NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        } else {
            //超时时间内未收到信号
            NLLogDebug(@"线程阻塞 %@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NLLogDebug(@"任务3完成 %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
        [context finished];
    });
}

+ (void)go_nslock:(PGRouterContext *)context {
    static NSLock *lock;
    if (!lock) {
        lock = [[NSLock alloc] init];
    }
    _count = 10;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self selliPhone:lock];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self selliPhone:lock];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self selliPhone:lock];
    });
    [context finished];
}

+ (void)selliPhone:(NSLock *)lock {
    while (YES) {
        sleep(2);
        [lock lock];
        if (_count > 0) {
            _count--;
            NLLogDebug(@"剩余iPhone = %ld，%@", _count, [NSThread currentThread]);
            [lock unlock];
        } else {
            NLLogDebug(@"iPhone卖光了 %@", [NSThread currentThread]);
            [lock unlock];
            break;
        }
    }
}

+ (void)go_pthread_mutex1:(PGRouterContext *)context {
    [self go_pthread_mutex2:context];
}

+ (void)go_pthread_mutex2:(PGRouterContext *)context {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([context.userInfo mc_boolForKey:@"try"]) {
            if (pthread_mutex_trylock(&_mutex) == 0) {
                NLLogDebug(@"进入临界区,开始锁定 %@", [NSThread currentThread]);
                sleep(3);
                NLLogDebug(@"解锁... %@", [NSThread currentThread]);
                pthread_mutex_unlock(&_mutex);
            } else {
                NLLogWarn(@"锁住了 %@", [NSThread currentThread]);
            }
        } else {
            if (pthread_mutex_lock(&_mutex) == 0) {
                NLLogDebug(@"进入临界区,开始锁定 %@", [NSThread currentThread]);
                sleep(3);
                NLLogDebug(@"解锁... %@", [NSThread currentThread]);
                pthread_mutex_unlock(&_mutex);
            } else {
                NLLogWarn(@"锁住了 %@", [NSThread currentThread]);
            }
        }
    });
    [context finished];
}

+ (void)go_NSCondition:(PGRouterContext *)context {
    static NSCondition *condition;
    static NSMutableArray *marr;
    if (!condition) {
        condition = [[NSCondition alloc] init];
        marr = [NSMutableArray array];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [condition lock];
        while (marr.count == 0) {
            NLLogDebug(@"等待产品");//让当前线程处于等待状态
            [condition wait];
        }
        [marr removeObjectAtIndex:0];
        NLLogDebug(@"包装产品");
        [condition unlock];
        [context finished];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [condition lock];
        sleep(2);
        [marr addObject:[NSDate date]];
        NLLogDebug(@"生产产品");
        [condition signal];//CPU发信号告诉线程不用在等待，可以继续执行
        [condition unlock];
    });
}

+ (void)go_NSConditionLock:(PGRouterContext *)context {
    //主线程中
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:4];
        NSLog(@"线程1");
        sleep(2);
        NLLogDebug(@"线程1解锁成功");
        [lock unlockWithCondition:5];
        [context finished];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:0];
        NSLog(@"线程2");
        sleep(3);
        NLLogDebug(@"线程2解锁成功");
        [lock unlockWithCondition:2];
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:2];
        NSLog(@"线程3");
        sleep(3);
        NLLogDebug(@"线程3解锁成功");
        [lock unlockWithCondition:3];
    });
    
    //线程4
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:3];
        NSLog(@"线程4");
        sleep(2);
        NLLogDebug(@"线程4解锁成功");
        [lock unlockWithCondition:4];
    });
}

+ (void)go_NSRecursiveLock:(PGRouterContext *)context {
    static NSRecursiveLock *lock;
    if (!lock) {
        lock = [[NSRecursiveLock alloc] init];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        static void (^RecursiveMethod)(int);
        
        RecursiveMethod = ^(int value) {
            
            [lock lock];
            if (value > 0) {
                
                NLLogDebug(@"value = %d", value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
        };
        
        RecursiveMethod(5);
        [context finished];
    });
}

@end
