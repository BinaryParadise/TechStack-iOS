//
//  NLTIRouterAction.h
//  NLTIRouterAction
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <TIRouterAction/NLTIRouterActionBase.h>
#import <TIRouterAction/NLTIRouterActionManager.h>
#import <MCJSONKit/MCJSONKit.h>

static DDLogLevel ddLogLevel = DDLogLevelVerbose;

#ifndef Header_h
#define Header_h

#if DEBUG
    #define MCLogError(frmt, ...)     DDLogError(@"" frmt, ##__VA_ARGS__)
    #define MCLogDebug(frmt, ...)     DDLogDebug(@"" frmt,  ##__VA_ARGS__)
    #define MCLogWarn(frmt, ...)      DDLogWarn(@"" frmt, ##__VA_ARGS__)
    #define MCLogInfo(frmt, ...)      DDLogInfo(@"" frmt, ##__VA_ARGS__)
    #define MCLogVerbose(frmt, ...)   DDLogVerbose(frmt, ##__VA_ARGS__)
#else
    #define MCLogInfo(frmt, ...)
    #define MCLogWarn(frmt, ...)
    #define MCLogError(frmt, ...)
    #define NSLog(...)
#endif

#define MACH_TIME_START    NSDate *startDate = [NSDate date];\

#define MACH_TIME_END(fmt)   MCLogWarn(fmt @"耗时：%.3fs", [NSDate date].timeIntervalSince1970 - startDate.timeIntervalSince1970);

#endif
