//
//  Header.h
//  iOSGuide
//
//  Created by odyang on 2017/10/8.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#ifndef Header_h
#define Header_h

#if DEBUG

#define PGLog(frmt, ...) NSLog(frmt,__func__,__LINE__, ##__VA_ARGS__);

#define LogSpec(frmt, ...) PGLog(@"⌘ %s+%d " frmt, ##__VA_ARGS__)
#define LogInfo(frmt, ...) PGLog(@"⌗ %s+%d " frmt, ##__VA_ARGS__)
#define LogWarn(frmt, ...) PGLog(@"⚠️ %s+%d " frmt, ##__VA_ARGS__)
#define LogError(frmt, ...) PGLog(@"‼️ %s+%d " frmt, ##__VA_ARGS__)

#else
#define LogInfo(frmt, ...)
#define LogWarn(frmt, ...)
#define LogError(frmt, ...)
#define NSLog(...)
#endif

#endif /* Header_h */
