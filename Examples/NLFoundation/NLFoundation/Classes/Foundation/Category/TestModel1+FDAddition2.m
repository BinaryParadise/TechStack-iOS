//
//  TestModel1+FDAddition2.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/21.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "TestModel1+FDAddition2.h"

@implementation NLTestModel1 (FDAddition2)

+ (void)load {
    NSLog(@"%s +%d 分类", __FUNCTION__, __LINE__);
}

- (void)testMethod {
    NLLogWarn(@"覆盖方法");
}

@end
