//
//  MCLockTableViewController.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/28.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterAction.h>

@interface MCLockActions : TIRouterActionBase

PGMethod(go_OSSpinLock, "fd://Foundation/Lock/OSSpinLock?c=自旋锁");

PGMethod(go_semaphore, "fd://Foundation/Lock/Semaphore?c=信号量");

PGMethod(go_nslock, "fd://Foundation/Lock/NSLock?c=简单的互斥锁");

PGMethod(go_pthread_mutex, "fd://Foundation/Lock/Mutex?c=c语言实现的互斥锁");

@end
