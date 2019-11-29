//
//  MCLockTableViewController.h
//  Neverland
//
//  Created by Rake Yang on 2019/2/28.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <NLRouterAction/NLRouterAction.h>

@interface NLMCLockActions : NLRouterActionBase

PGMethod(trigger_DeadLock, "fd://Foundation/Lock/DeadLock?c=造成线程死锁");
PGMethod(go_OSSpinLock, "fd://Foundation/Lock/OSSpinLock?c=自旋锁（不再安全）");
PGMethod(go_OSUnfairLock, "ft://Foundation/Lock/OSUnfairLock?c=自旋锁，iOS 10替代方案");

PGMethod(go_semaphore, "fd://Foundation/Lock/Semaphore?c=信号量");

PGMethod(go_nslock, "fd://Foundation/Lock/NSLock?c=简单的互斥锁");

PGMethod(go_pthread_mutex1, "fd://Foundation/Lock/Mutex?c=c语言实现的互斥锁");
PGMethod(go_pthread_mutex2, "fd://Foundation/Lock/MutexTry?c=c语言实现的互斥锁&try=1");

PGMethod(go_NSCondition, "fd://Foundation/Lock/NSCondition?c=线程检查器和锁");
PGMethod(go_NSConditionLock, "fd://Foundation/Lock/NSConditionLock?c=条件锁");
PGMethod(go_NSRecursiveLock, "fd://Foundation/Lock/NSRecursiveLock?c=递归锁");

@end
