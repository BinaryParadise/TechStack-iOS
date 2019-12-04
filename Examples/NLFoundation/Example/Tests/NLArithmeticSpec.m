//
//  NLArithmeticSpec.m
//  NLFoundation_Tests
//
//  Created by Rake Yang on 2019/12/4.
//  Copyright © 2019年 rakeyang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NLArithmeticSpec : XCTestCase

@end

@implementation NLArithmeticSpec

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    NSMutableArray<NSNumber *> *nums = [NSMutableArray array];
    int target = 18888;
    for (int i=0; i<20000; i++) {
        [nums addObject:@(i+1)];
    }
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        //暴力法
        for (int i=0; i<nums.count; i++) {
            for (int j=i+1; j<nums.count; j++) {
                if (nums[i].intValue == target - nums[j].intValue) {
                    printf("%d,%d\n", i, j);
                    return;
                }
            }
        }
        return;
        //哈希表
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        for (int i=0; i<nums.count; i++) {
            int temp = target - nums[i].intValue;
            if ([mdict.allKeys containsObject:@(temp)]) {
                printf("%d,%d\n", [mdict[@(temp)] intValue], i);
                break;
            }
            mdict[nums[i]] = @(i);
        }
    }];
}

@end
