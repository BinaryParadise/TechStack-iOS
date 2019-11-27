//
//  NLTestModel1.m
//  iOSGuide
//
//  Created by Rake Yang on 2017/10/10.
//  Copyright © 2017年 BinaryParadise. All rights reserved.
//

#import "NLTestModel1.h"

@interface NLTestModel1 ()

@end

@implementation NLTestModel1

+ (void)load {
    NSLog(@"%s +%d 父类", __FUNCTION__, __LINE__);
}

- (void)testMethod {
    MCLogWarn(@"父类方法");
}

@end
