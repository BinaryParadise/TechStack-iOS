//
//  TestModel1.m
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/10.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "TestModel1.h"

@implementation TestModel1

+ (void)load {
    NSLog(@"%s +%d 类", __FUNCTION__, __LINE__);
}

+ (void)initialize {
    NSLog(@"%s +%d 类", __FUNCTION__, __LINE__);
}

- (void)testMethod {
    MCLogWarn(@"原始方法");
}

@end
