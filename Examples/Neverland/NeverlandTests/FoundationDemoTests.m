//
//  NeverlandTests.m
//  NeverlandTests
//
//  Created by Rake Yang on 2019/1/31.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <NLDataType/NSNumber+JSConvert.h>
@import NLFoundation;

SpecBegin(NeverlandSpec)

describe(@"Foundation", ^{

    context(@"浮点数精确计算", ^{
        // 精确小数点计算
        NSString *num1 = @"71.49";
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
            expect(subNum.stringValue).equal(@"71.48999999999");
        });
        it(@"乘法", ^{
            NSDecimalNumber *multiNum = [number4 decimalNumberByMultiplyingBy:number2];
            expect(multiNum.stringValue).equal(@"0.0000000000123456789876");
            NSDecimalNumber *result = [number1 decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
            expect(result.stringValue).equal(@"7149");
        });
        it(@"除法", ^{
            NSDecimalNumber *dividNum = [number4 decimalNumberByDividingBy:number2];
            expect(dividNum.stringValue).equal(@"123456789876");
        });
    });

    context(@"NSArray", ^{

    });

    context(@"单例模式", ^{
    NLSingletonDemo *singleton = [[NLSingletonDemo alloc] init];
        it(@"校验", ^{
            expect(singleton).equal([NLSingletonDemo sharedManager]);
            expect(singleton).equal([NLSingletonDemo new]);
            expect(singleton).equal([singleton copy]);
            expect(singleton).equal([singleton mutableCopy]);
            expect(singleton).equal([[NLSingletonDemo alloc] init]);
        });
    });
    
    context(@"Regular", ^{
        NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"(href=\")(\\S+)(\")" options:NSRegularExpressionCaseInsensitive error:nil];
        NSString *text = @"<a href=\"http://weibo.com\" rel=\"nofollow\">新浪微博</a>";
        NSTextCheckingResult *result = [[NSRegularExpression regularExpressionWithPattern:@"(>)(\\s*\\S*)(<\\/a>)" options:NSRegularExpressionCaseInsensitive error:nil] firstMatchInString:text options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, text.length)];
        expect([text substringWithRange:[result rangeAtIndex:2]]).equal(@"新浪微博");
        NSArray<NSTextCheckingResult *> *matches = [regx matchesInString:text options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, text.length)];
        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            expect([text substringWithRange:[obj rangeAtIndex:2]]).equal(@"http://weibo.com");
        }];
    });
});

SpecEnd
