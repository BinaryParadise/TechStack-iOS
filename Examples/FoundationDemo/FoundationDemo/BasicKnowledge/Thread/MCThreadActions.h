//
//  MCThreadViewController.h
//  FoundationDemo
//
//  Created by joengzi on 2019/2/24.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <TIRouterAction/TIRouterAction.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCThreadActions : TIRouterActionBase

+ (void)demo_NSThread:(PGRouterContext *)context PGTarget("fd://Thread/NSThread");

+ (void)demo_GCD:(PGRouterContext *)context PGTarget("fd://Thread/GCD");

+ (void)demo_GCDGroup:(PGRouterContext *)context PGTarget("fd://Thread/GCD_Group");

+ (void)dem_temp:(PGRouterContext *)context PGTarget("fd://Thread/Temp");

@end

NS_ASSUME_NONNULL_END
