//
//  FDBasicActions.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/9/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FDBasicActions.h"
#import "FDRefrigerator.h"

static FDAutoMonitor *monitor;

@implementation FDBasicActions

+ (void)load {
    monitor = [FDAutoMonitor new];
}

+ (void)kvoDemo:(PGRouterContext *)context {
    monitor.refrigerator.cold.temperature = 10.0;
    [context finished];
}

@end
