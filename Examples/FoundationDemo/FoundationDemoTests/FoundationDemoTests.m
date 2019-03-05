//
//  FoundationDemoTests.m
//  FoundationDemoTests
//
//  Created by joengzi on 2019/1/31.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "NSNumber+JSConvert.h"
#import "MCSingletonDemo.h"

SpecBegin(FoundationDemoSpec)

describe(@"Foundation", ^{

    context(@"浮点数精确计算", ^{
        // 精确小数点计算
        NSString *num1 = @"1.99999999999";
        NSString *num2 = @"0.00000000001";
        NSString *num3 = @"0.00000001234";
        NSString *num4 = @"1.23456789876";

        // 创建NSDecimalNumber对象
        NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:num1];
        NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:num2];
        NSDecimalNumber *number3 = [NSDecimalNumber decimalNumberWithString:num3];
        NSDecimalNumber *number4 = [NSDecimalNumber decimalNumberWithString:num4];

        it(@"加法", ^{
            NSDecimalNumber *sumNum = [number2 decimalNumberByAdding:number3];
            expect(sumNum.stringValue).equal(@"0.00000001235");
        });
        it(@"减法", ^{
            NSDecimalNumber *subNum = [number1 decimalNumberBySubtracting:number2];
            expect(subNum.stringValue).equal(@"1.99999999998");
        });
        it(@"乘法", ^{
            NSDecimalNumber *multiNum = [number4 decimalNumberByMultiplyingBy:number2];
            expect(multiNum.stringValue).equal(@"0.0000000000123456789876");
        });
        it(@"除法", ^{
            NSDecimalNumber *dividNum = [number4 decimalNumberByDividingBy:number2];
            expect(dividNum.stringValue).equal(@"123456789876");
        });
    });

    context(@"NSArray", ^{

    });

    context(@"单例模式", ^{
        MCSingletonDemo *singleton = [[MCSingletonDemo alloc] init];
        it(@"校验", ^{
            expect(singleton).equal([MCSingletonDemo new]);
            expect(singleton).equal([singleton copy]);
            expect(singleton).equal([singleton mutableCopy]);
            expect(singleton).equal([[MCSingletonDemo alloc] init]);
        });
    });
});

SpecEnd
