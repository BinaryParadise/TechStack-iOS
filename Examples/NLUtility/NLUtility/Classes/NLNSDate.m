//
//  NLNSDate.m
//  Neverland
//
//  Created by Rake Yang on 2019/11/7.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLNSDate.h"
#include <sys/sysctl.h>

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

/// 获取设备已启动时间（秒），设备重启会导致系统时间变回自动同步
NSTimeInterval bootTimeInterval() {
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    sysctl(mib, sizeof(mib)/sizeof(int), &boottime, &size, NULL, 0);
    //受系统时间影响
    return NSDate.date.timeIntervalSince1970 - (boottime.tv_sec + boottime.tv_usec/1000000.0);
}

+ (instancetype)serverDate {
    //http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp
    NSTimeInterval serverTime = [NSUserDefaults.standardUserDefaults doubleForKey:@"ServerTimestamp"];
    NSTimeInterval bootInterval = [NSUserDefaults.standardUserDefaults doubleForKey:@"BootTimeInterval"];
    if (serverTime == 0 || bootTimeInterval() < bootInterval) {
        if (serverTime == 0) {
            serverTime = NSDate.date.timeIntervalSince1970;
        }
        [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data.length) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    NSNumber *t = dict[@"data"][@"t"];
                    NSLog(@"时间同步成功 %@，启动时间：%.2f(秒)", [NSDate dateWithTimeIntervalSince1970:t.doubleValue/1000.0], bootTimeInterval());
                    //设备启动时间间隔（不收系统时间影响）
                    [NSUserDefaults.standardUserDefaults setDouble:bootTimeInterval() forKey:@"BootTimeInterval"];
                    [NSUserDefaults.standardUserDefaults setDouble:t.doubleValue/1000.0 forKey:@"ServerTimestamp"];
                }
            }
        }] resume];
    }
    NSTimeInterval interval = (bootTimeInterval() - bootInterval);
    return [NSDate dateWithTimeIntervalSince1970:serverTime + interval];
}

@end
