//
//  Header.h
//  FoundationDemo
//
//  Created by joengzi on 2019/2/1.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import <CocoaLumberjack/DDLog.h>

static DDLogLevel ddLogLevel = DDLogLevelVerbose;

#ifndef Header_h
#define Header_h

#if DEBUG
    #define LogInfo(frmt, ...)      DDLogInfo(@"✢ " frmt, ##__VA_ARGS__);
    #define LogDebug(frmt, ...)     DDLogDebug(@"◦ " frmt, ##__VA_ARGS__);
    #define LogWarn(frmt, ...)      DDLogWarn(@"⚡︎ " frmt, ##__VA_ARGS__);
    #define LogError(frmt, ...)     DDLogError(@"‼️ " frmt, ##__VA_ARGS__);
    #define LogVerbose(frmt, ...)   DDLogVerbose(frmt, ##__VA_ARGS__);
#else
    #define LogInfo(frmt, ...)
    #define LogWarn(frmt, ...)
    #define LogError(frmt, ...)
    #define NSLog(...)
#endif

#define MACH_TIME_START    NSDate *startDate = [NSDate date];\

#define MACH_TIME_END(fmt)   LogWarn(fmt @"：%f", [NSDate date].timeIntervalSince1970 - startDate.timeIntervalSince1970);

#endif /* Header_h */
