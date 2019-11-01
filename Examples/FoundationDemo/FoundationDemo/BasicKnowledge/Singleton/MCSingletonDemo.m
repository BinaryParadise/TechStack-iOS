//
//  MCSingletonDemo.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/3/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "MCSingletonDemo.h"

@implementation MCSingletonDemo

#pragma mark - Singleton

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)sharedManager {
    return [[self alloc] init];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (instancetype)mutableCopyWithZone:(struct _NSZone *)zone {
    return self;
}

@end
