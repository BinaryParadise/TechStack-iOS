//
//  FDRefrigerator.h
//  FoundationDemo
//
//  Created by lingjing on 2019/9/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 冰箱：冷藏室
 */
@interface FDColdRoom : NSObject

/**
 温度，默认8.0°C
 */
@property (nonatomic, assign) double temperature;

@end

/**
 冰箱
 */
@interface FDRefrigerator : NSObject

@property (nonatomic, strong) FDColdRoom *cold;

@end

@interface FDAutoMonitor : NSObject

@property (nonatomic, strong) FDRefrigerator *refrigerator;

@end

NS_ASSUME_NONNULL_END
