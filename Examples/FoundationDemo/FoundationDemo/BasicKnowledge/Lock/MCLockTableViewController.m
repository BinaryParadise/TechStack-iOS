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

@interface MCLockTableViewController ()

@end

@implementation MCLockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1); //传入值必须 >0, 若传入为0则阻塞线程并等待timeout,时间到后会执行其后的语句
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            // 相当于加锁
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            LogDebug(@"i = %d semaphore = %@", i, semaphore);
            sleep(1.0);
            // 相当于解锁
            dispatch_semaphore_signal(semaphore);
            
        });
    }
}

@end
