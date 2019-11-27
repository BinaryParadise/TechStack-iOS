//
//  NLNSDate.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/7.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLNSDate.h"

@implementation NLNSDate

@end

@implementation NSDate (Extension)

- (NSString *)localTimeString {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:self];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    NSString *fmtStr = @"yyyy-MM-dd HH:mm:ss";
    switch (dayComponents.day) {
        case 0: fmtStr = @"HH:mm:ss";break;
        case 1: fmtStr = @"昨天 HH:mm:ss";break;
        case 2: fmtStr = @"前天 HH:mm:ss";break;
        default:break;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = fmtStr;
    return [formatter stringFromDate:self];
}

@end
