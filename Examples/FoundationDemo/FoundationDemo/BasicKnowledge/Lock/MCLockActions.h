//
//  MCLockTableViewController.h
//  FoundationDemo
//
//  Created by joengzi on 2019/2/28.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterAction.h>

@interface MCLockActions : TIRouterActionBase

+ (void)go_OSSpinLock:(PGRouterContext *)context PGTarget("ft://Lock/OSSpinLock?c=自旋锁");

+ (void)go_semaphore:(PGRouterContext *)context PGTarget("ft://Lock/Semaphore?c=信号量");

+ (void)go_nslock:(PGRouterContext *)context PGTarget("ft://Lock/NSLock?c=简单的互斥锁");

+ (void)go_pthread_mutex:(PGRouterContext *)context PGTarget("ft://Lock/Mutex?c=c语言实现的互斥锁");

@end
