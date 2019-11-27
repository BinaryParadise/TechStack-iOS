//
//  TestModel1.m
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/10.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "TestModel1.h"

@interface TestModel1 ()

@end

@implementation TestModel1

+ (void)load {
    NSLog(@"%s +%d 父类", __FUNCTION__, __LINE__);
}

- (void)testMethod {
    MCLogWarn(@"父类方法");
}

@end
