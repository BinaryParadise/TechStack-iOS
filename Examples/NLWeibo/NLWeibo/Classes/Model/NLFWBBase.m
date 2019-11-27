//
//  NLFWBBase.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/11/4.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLFWBBase.h"
#import <MCJSONKit/MCJSONKit.h>

@implementation NLFWBBase

- (id)fd_newValueFromOldValue:(id)oldValue property:(MCJSONKitProperty *)property {
    if ([oldValue isKindOfClass:[NSString class]] && property.typeClass == [NSDate class]) {
        NSDateFormatter *dateFmt = [NSDateFormatter new];
        dateFmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
        dateFmt.locale = [NSLocale localeWithLocaleIdentifier:@"en-US"];
        NSDate *date = [dateFmt dateFromString:oldValue];
        return @(date.timeIntervalSince1970);
    }
    return oldValue;
}

@end
