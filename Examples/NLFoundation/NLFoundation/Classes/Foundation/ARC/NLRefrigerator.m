//
//  NLRefrigerator.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/9/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLRefrigerator.h"
#import <TIRouterAction/TIRouterAction.h>

@implementation FDColdRoom

- (instancetype)init
{
    self = [super init];
    if (self) {
        _temperature = 8.0;
    }
    return self;
}

@end

@implementation NLRefrigerator

- (instancetype)init {
    if (self = [super init]) {
        self.cold = [FDColdRoom new];
    }
    return self;
}

@end

@implementation FDAutoMonitor

- (instancetype)init {
    if (self = [super init]) {
        _refrigerator = [[NLRefrigerator alloc] init];
        [_refrigerator addObserver:self forKeyPath:@"cold.temperature" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSNumber *temperature = change[NSKeyValueChangeNewKey];
    MCLogDebug(@"当前冰箱冷藏室设定温度:%.2f°C", temperature.doubleValue);
}

@end
