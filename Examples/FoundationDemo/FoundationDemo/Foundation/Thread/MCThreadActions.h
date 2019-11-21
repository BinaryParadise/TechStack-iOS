//
//  MCThreadViewController.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/2/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterAction.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCThreadActions : TIRouterActionBase

PGMethod(demo_NSThread, "fd://Foundation/Thread/NSThread");

PGMethod(demo_GCD, "fd://Foundation/Thread/GCD");

PGMethod(demo_GCDGroup, "fd://Foundation/Thread/GCD_Group");

PGMethod(dem_temp, "fd://Foundation/Thread/Temp");

@end

NS_ASSUME_NONNULL_END
