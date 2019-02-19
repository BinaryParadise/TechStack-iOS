//
//  Header.h
//  FoundationDemo
//
//  Created by joengzi on 2019/2/1.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import <MCLogger/MCLogger.h>

#ifndef Header_h
#define Header_h

#if DEBUG
    #define LogInfo(frmt, ...) MCLogInfo(@"✢ " frmt, ##__VA_ARGS__);
    #define LogDebug(frmt, ...) MCLogDebug(@"◦ " frmt, ##__VA_ARGS__);
    #define LogWarn(frmt, ...) MCLogWarn(@"⚡︎ " frmt, ##__VA_ARGS__);
    #define LogError(frmt, ...) MCLogError(@"‼️ " frmt, ##__VA_ARGS__);
    #define LogVerbose(frmt, ...) MCLogVerbose(frmt, ##_VA_ARGS__);
#else
    #define LogInfo(frmt, ...)
    #define LogWarn(frmt, ...)
    #define LogError(frmt, ...)
    #define NSLog(...)
#endif

#define MACH_TIME_START    NSDate *startDate = [NSDate date];\

#define MACH_TIME_END(fmt)   LogWarn(fmt @"：%f", [NSDate date].timeIntervalSince1970 - startDate.timeIntervalSince1970);

#endif /* Header_h */
