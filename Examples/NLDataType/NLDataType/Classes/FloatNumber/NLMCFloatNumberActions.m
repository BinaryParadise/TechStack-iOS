//
//  NLMCFloatNumberActions.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/1/31.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLMCFloatNumberActions.h"

@interface NLMCFloatNumberActions ()

@end

@implementation NLMCFloatNumberActions

+ (void)processFloat:(PGRouterContext *)context {
    NSString *jsonStr = @"{\"price\":71.6356867}";
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSNumber *price = dict[@"price"];
    NSString *priceStr = [NSString stringWithFormat:@"%lf", price.doubleValue];
    MCLogInfo(@"处理之前：%@ = %@ %d", [price stringValue], priceStr, [priceStr isEqualToString:price.stringValue]);
    
    NSDecimalNumber *decimalPrice = [NSDecimalNumber decimalNumberWithString:priceStr];
    MCLogDebug(@"处理之后：%@", [decimalPrice stringValue]);
    
    NSString *inputStr = @"0.21";
    
    MCLogDebug(@"%@", @(inputStr.doubleValue * 1.0));
    
    [context onDone:YES object:nil];
}

@end
