//
//  MCLockTableViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/2/28.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "MCLockTableViewController.h"
#import <libkern/OSAtomic.h>
#include <pthread/pthread.h>

static OSSpinLock oslock = OS_SPINLOCK_INIT;

@interface MCLockTableViewController () {
    NSUInteger _count;
    pthread_mutex_t _mutex;
}

@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, copy) NSDictionary<NSNumber *, NSString *> *actionsDict;

@end

@implementation MCLockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _actionsDict = @{@(1000):@"go_OSSpinLock",
                     @(1001):@"go_semaphore",
                     @(1002):@"go_pthread_mutex",
                     @(1003):@"go_nslock",
                     };


    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);

    pthread_mutex_init(&_mutex, &attr);//创建锁

    self.lock = [[NSLock alloc] init];
}

#pragma mark - Actions

- (IBAction)go_OSSpinLock {
    LogWarn(@"");
    /**
     适用于等待队列任务
     0表示可以上锁
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if(OSSpinLockTry(&oslock)) {
            LogDebug(@"%@ 上锁%d", [NSThread currentThread], oslock);
            sleep(3);
            LogDebug(@"%@ 恢复%d", [NSThread currentThread], oslock);
            OSSpinLockUnlock(&oslock);
            LogDebug(@"%@ 解锁%d", [NSThread currentThread], oslock);
            LogDebug(@"--------------------------------------------------------");
        }
    });
}

- (IBAction)go_semaphore {
    LogWarn("----------------------信号量----------------------");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1); //传入值必须 >0, 若传入为0则阻塞线程并等待timeout,时间到后会执行其后的语句
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        sleep(3);
        LogDebug(@"任务1完成 %@", [NSThread currentThread])
        long ret = dispatch_semaphore_signal(semaphore);
        LogDebug(@"%ld线程等待 %@",ret, [NSThread currentThread])
    });
    dispatch_async(queue, ^{
        //此刻信号量为0，线程阻塞等待信号唤起，超时时间2秒
        long ret = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC));
        if (ret == 0) {//分支处理
            //收到信号，继续执行
            LogDebug(@"任务2完成 %@", [NSThread currentThread])
            dispatch_semaphore_signal(semaphore);
        } else {
            //超时时间内未收到信号
            LogDebug(@"线程阻塞 %@", [NSThread currentThread])
        }
    });
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        LogDebug(@"任务3完成 %@", [NSThread currentThread])
        dispatch_semaphore_signal(semaphore);
    });
}

- (IBAction)go_nslock {
    _count = 5;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self selliPhone];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self selliPhone];
    });
}

- (void)selliPhone {
    while (YES) {
        sleep(0.5);
        //[self.lock lock];
        if (_count > 0) {
            _count--;
            LogDebug(@"剩余iPhone= %ld，%@", _count, [NSThread currentThread]);
        } else {
            LogDebug(@"iPhone卖光了 %@", [NSThread currentThread]);
            break;
        }
        //[self.lock unlock];
    }
}

- (void)go_pthread_mutex {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (pthread_mutex_trylock(&self->_mutex) == 0) {
            LogDebug(@"进入临界区,开始锁定 %@", [NSThread currentThread]);
            sleep(3);
            LogDebug(@"解锁... %@", [NSThread currentThread]);
            pthread_mutex_unlock(&self->_mutex);
        } else {
            LogDebug(@"加锁中 %@", [NSThread currentThread]);
        }
    });
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger tag = [tableView cellForRowAtIndexPath:indexPath].tag;
    NSString *selector = [self.actionsDict objectForKey:@(tag)];
    if (selector.length > 0) {
        if([self respondsToSelector:NSSelectorFromString(selector)]) {
            [self performSelector:NSSelectorFromString(selector) withObject:nil];
        }
    }
}

@end
