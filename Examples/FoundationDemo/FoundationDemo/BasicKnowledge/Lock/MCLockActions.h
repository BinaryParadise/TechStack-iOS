//
//  MCLockTableViewController.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/28.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterAction.h>

@interface MCLockActions : TIRouterActionBase

PGMethod(go_OSSpinLock, "ft://Lock/OSSpinLock?c=自旋锁");

PGMethod(go_semaphore, "ft://Lock/Semaphore?c=信号量");

PGMethod(go_nslock, "ft://Lock/NSLock?c=简单的互斥锁");

PGMethod(go_pthread_mutex, "ft://Lock/Mutex?c=c语言实现的互斥锁");

@end
