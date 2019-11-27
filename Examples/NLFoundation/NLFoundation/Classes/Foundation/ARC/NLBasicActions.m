//
//  NLBasicActions.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/9/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLBasicActions.h"
#import "NLRefrigerator.h"
#import "NLARCViewController.h"
#import <NLModuleService/NLModuleService.h>

static FDAutoMonitor *monitor;

@implementation NLBasicActions

+ (void)load {
    monitor = [FDAutoMonitor new];
}

+ (void)kvoDemo:(PGRouterContext *)context {
    monitor.refrigerator.cold.temperature = 10.0;
    [context finished];
}

+ (void)kvcDemo:(PGRouterContext *)context {
    
}

+ (void)arcDemo:(PGRouterContext *)context {
    NLARCViewController *vc = [[NLARCViewController alloc] initWithNibName:nil bundle:NLM_Foundation.resourceBundle];
    [self pushViewController:vc animated:YES];
    [context finished];
}

@end
