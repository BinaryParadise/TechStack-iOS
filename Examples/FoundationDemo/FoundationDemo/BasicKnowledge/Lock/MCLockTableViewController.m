//
//  MCLockTableViewController.m
//  FoundationDemo
//
//  Created by joengzi on 2019/2/28.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "MCLockTableViewController.h"
#import <libkern/OSAtomic.h>

static OSSpinLock oslock = OS_SPINLOCK_INIT;

@interface MCLockTableViewController () {
    NSUInteger _count;
}

@property (nonatomic, strong) NSLock *lock;

@end

@implementation MCLockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.lock = [[NSLock alloc] init];
}

- (IBAction)go_OSSpinLock:(id)sender {
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

- (IBAction)go_semaphore:(id)sender {
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

- (IBAction)go_nslock:(id)sender {
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

@end
