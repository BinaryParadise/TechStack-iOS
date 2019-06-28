//
//  Header.h
//  FoundationDemo
//
//  Created by joengzi on 2019/2/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

static DDLogLevel ddLogLevel = DDLogLevelVerbose;

#ifndef Header_h
#define Header_h

#if DEBUG
    #define MCLogInfo(frmt, ...)      DDLogInfo(@"" frmt, ##__VA_ARGS__);
    #define MCLogDebug(frmt, ...)     DDLogDebug(@"" frmt, ##__VA_ARGS__);
    #define MCLogWarn(frmt, ...)      DDLogWarn(@"" frmt, ##__VA_ARGS__);
    #define MCLogError(frmt, ...)     DDLogError(@"" frmt, ##__VA_ARGS__);
    #define MCLogVerbose(frmt, ...)   DDLogVerbose(frmt, ##__VA_ARGS__);
    #define NSLog(frmt, ...)          DDLogInfo(@"" frmt, ##__VA_ARGS__);
#else
    #define MCLogInfo(frmt, ...)
    #define MCLogWarn(frmt, ...)
    #define MCLogError(frmt, ...)
    #define NSLog(...)
#endif

#define MACH_TIME_START    NSDate *startDate = [NSDate date];\

#define MACH_TIME_END(fmt)   MCLogWarn(fmt @"：%f", [NSDate date].timeIntervalSince1970 - startDate.timeIntervalSince1970);

#endif /* Header_h */
