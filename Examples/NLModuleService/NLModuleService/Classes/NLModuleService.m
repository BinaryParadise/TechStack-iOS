//
//  NLModuleService.m
//  NLModuleService
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLModuleService.h"

@interface NLModuleService ()

@property (nonatomic, strong) NSMutableArray<id<NLModuleService>> *marr;


@end

@implementation NLModuleService

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
        //这里会执行多次
    }
    return self;
}

+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (instancetype)mutableCopyWithZone:(struct _NSZone *)zone {
    return self;
}

- (NSMutableArray<id<NLModuleService>> *)marr {
    if (!_marr) {
        _marr = [NSMutableArray array];
    }
    return _marr;
}

- (void)registerModule:(id<NLModuleService>)module forProtocol:(Protocol *)protocol {
    NSAssert([module conformsToProtocol:@protocol(NLModuleService)], @"必须实现协议:%@", NSStringFromProtocol(@protocol(NLModuleService)));
    NSAssert([module conformsToProtocol:protocol], @"必须实现协议:%@", NSStringFromProtocol(protocol));
    for (id<NLModuleService> obj in self.marr) {
        if ([obj conformsToProtocol:protocol]) {
            NSAssert(NO, @"请勿重新重复注册:%@", NSStringFromProtocol(protocol));
            return;
        }
    }
    
    [self.marr addObject:module];
}

- (id)moduleForProtocol:(Protocol *)protocol {
    id module;
    for (id<NLModuleService> obj in self.marr) {
        if ([obj conformsToProtocol:protocol]) {
            module = obj;
            break;
        }
    }
    NSAssert(module, @"组件未注册:%@", NSStringFromProtocol(protocol));
    return module;
}

@end
