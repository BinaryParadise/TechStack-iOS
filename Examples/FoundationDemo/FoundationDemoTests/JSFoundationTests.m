//
//  JSFoundationTests.m
//  FoundationDemoTests
//
//  Created by joengzi on 2019/2/20.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface JSFoundationTests : XCTestCase

@end

@implementation JSFoundationTests

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
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        printf("%lf\n", sqrtV2(999));
    }];
}

/**
 
 */
double sqrtV2(long num) {
    double res = num;
    while (res * res > num) {
        res = (res + num / res) / 2.0;
    }
    return res;
}

@end
