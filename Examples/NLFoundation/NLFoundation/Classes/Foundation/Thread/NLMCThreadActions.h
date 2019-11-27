//
//  MCThreadViewController.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterAction.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLMCThreadActions : TIRouterActionBase

PGMethod(demo_NSThread, "fd://Foundation/Thread/NSThread");

PGMethod(demo_GCD_main, "fd://Foundation/Thread/GCD/main?c=主队列");
PGMethod(demo_GCD_serial, "fd://Foundation/Thread/GCD/serial?c=串行队列");
PGMethod(demo_GCD_concurrent, "fd://Foundation/Thread/GCD/concurrent?c=并行队列");
PGMethod(demo_GCD_barrier, "fd://Foundation/Thread/GCD/barrier?c=栅栏");
PGMethod(demo_GCDGroup, "fd://Foundation/Thread/GCD/Group?c=分组队列");

PGMethod(dem_temp, "fd://Foundation/Thread/Temp");

@end

NS_ASSUME_NONNULL_END
