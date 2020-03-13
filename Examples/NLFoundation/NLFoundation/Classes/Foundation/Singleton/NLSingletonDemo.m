//
//  NLMCSingletonDemo.m
//  Neverland
//
//  Created by Rake Yang on 2019/3/5.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLSingletonDemo.h"

@implementation NLSingletonDemo

#pragma mark - Singleton

- (instancetype)init
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
    });
    return instance;
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
