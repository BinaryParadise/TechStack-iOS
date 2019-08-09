//
//  MCLockTableViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/2/28.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "MCLockActions.h"
#import <libkern/OSAtomic.h>
#include <pthread/pthread.h>

static OSSpinLock oslock = OS_SPINLOCK_INIT;
static NSUInteger _count;
static pthread_mutex_t _mutex;

@interface MCLockActions () {
}

@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, copy) NSDictionary<NSNumber *, NSString *> *actionsDict;

@end

@implementation MCLockActions

- (instancetype)init {
    if (self = [super init]) {
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);
        
        pthread_mutex_init(&_mutex, &attr);//创建锁
        
        self.lock = [[NSLock alloc] init];
    }
    return self;
}

#pragma mark - Actions

+ (void)go_OSSpinLock:(PGRouterContext *)context PGTarget("ft://Lock/OSSpinLock") {
    MCLogWarn(@"");
    /**
     适用于等待队列任务
     0表示可以上锁
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if(OSSpinLockTry(&oslock)) {
            MCLogDebug(@"%@ 上锁%d", [NSThread currentThread], oslock);
            sleep(3);
            MCLogDebug(@"%@ 恢复%d", [NSThread currentThread], oslock);
            OSSpinLockUnlock(&oslock);
            MCLogDebug(@"%@ 解锁%d", [NSThread currentThread], oslock);
            MCLogDebug(@"--------------------------------------------------------");
        }
    });
}

+ (void)go_semaphore:(PGRouterContext *)context PGTarget("ft://Lock/semaphore") {
    MCLogWarn("----------------------信号量----------------------");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1); //传入值必须 >0, 若传入为0则阻塞线程并等待timeout,时间到后会执行其后的语句
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        sleep(3);
        MCLogDebug(@"任务1完成 %@", [NSThread currentThread]);
        long ret = dispatch_semaphore_signal(semaphore);
        MCLogDebug(@"%ld线程等待 %@",ret, [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        //此刻信号量为0，线程阻塞等待信号唤起，超时时间2秒
        long ret = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC));
        if (ret == 0) {//分支处理
            //收到信号，继续执行
            MCLogDebug(@"任务2完成 %@", [NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        } else {
            //超时时间内未收到信号
            MCLogDebug(@"线程阻塞 %@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        MCLogDebug(@"任务3完成 %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
}

+ (void)go_nslock:(PGRouterContext *)context PGTarget("ft://Lock/NSLock") {
    _count = 5;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self selliPhone];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self selliPhone];
    });
}

+ (void)selliPhone {
    while (YES) {
        sleep(0.5);
        //[self.lock lock];
        if (_count > 0) {
            _count--;
            MCLogDebug(@"剩余iPhone = %ld，%@", _count, [NSThread currentThread]);
        } else {
            MCLogDebug(@"iPhone卖光了 %@", [NSThread currentThread]);
            break;
        }
        //[self.lock unlock];
    }
}

+ (void)go_pthread_mutex:(PGRouterContext *)context PGTarget("ft://Lock/mutex") {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (pthread_mutex_trylock(&_mutex) == 0) {
            MCLogDebug(@"进入临界区,开始锁定 %@", [NSThread currentThread]);
            sleep(3);
            MCLogDebug(@"解锁... %@", [NSThread currentThread]);
            pthread_mutex_unlock(&_mutex);
        } else {
            MCLogDebug(@"加锁中 %@", [NSThread currentThread]);
        }
    });
}

@end
