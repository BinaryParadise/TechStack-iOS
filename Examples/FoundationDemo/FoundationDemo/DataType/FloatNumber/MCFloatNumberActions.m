//
//  MCFloatNumberActions.m
//  FoundationDemo
//
//  Created by joengzi on 2019/1/31.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "MCFloatNumberActions.h"

@interface MCFloatNumberActions ()

@end

@implementation MCFloatNumberActions

- (void)processFloat {
    NSString *jsonStr = @"{\"price\":71.49}";
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSNumber *price = dict[@"price"];
    NSString *priceStr = [NSString stringWithFormat:@"%lf", price.doubleValue];
    MCLogInfo(@"处理之前：%@，=? %d", [price stringValue], [priceStr isEqualToString:@"71.49"]);
    
    NSDecimalNumber *decimalPrice = [NSDecimalNumber decimalNumberWithString:price.stringValue];
    MCLogDebug(@"处理之后：%@", [decimalPrice stringValue]);
}

@end
