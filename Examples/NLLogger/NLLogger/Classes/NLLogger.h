//
//  NLLogger.h
//  NLLogger
//
//  Created by Rake Yang on 2019/11/27.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <NLLogger/NLLoggerModule.h>

static DDLogLevel ddLogLevel = DDLogLevelVerbose;

#ifndef Header_h
#define Header_h

#if DEBUG
    #define NLLogError(frmt, ...)     DDLogError(@"" frmt, ##__VA_ARGS__)
    #define NLLogDebug(frmt, ...)     DDLogDebug(@"" frmt,  ##__VA_ARGS__)
    #define NLLogWarn(frmt, ...)      DDLogWarn(@"" frmt, ##__VA_ARGS__)
    #define NLLogInfo(frmt, ...)      DDLogInfo(@"" frmt, ##__VA_ARGS__)
    #define NLLogVerbose(frmt, ...)   DDLogVerbose(frmt, ##__VA_ARGS__)
#else
    #define NLLogInfo(frmt, ...)
    #define NLLogWarn(frmt, ...)
    #define NLLogError(frmt, ...)
    #define NSLog(...)
#endif

#endif
