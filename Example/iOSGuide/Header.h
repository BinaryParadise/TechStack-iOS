//
//  Header.h
//  iOSGuide
//
//  Created by odyang on 2017/10/8.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "ARCDemo.h"

#if DEBUG

//需要安装XcodeColors插件才能正确显示彩色日志

//#define UseXcodeColors //注释以关闭XcodeColors插件

#ifndef UseXcodeColors

#define LogInfo(frmt, ...) NSLog((@"%s+%d " frmt),__func__,__LINE__, ##__VA_ARGS__)
#define LogWarn(frmt, ...) LogInfo(frmt, ##__VA_ARGS__)
#define LogError(frmt, ...) LogInfo(frmt, ##__VA_ARGS__)

#endif

#ifdef UseXcodeColors

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define LogSpec(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg222,152,252;%s+%d " frmt XCODE_COLORS_RESET),__func__,__LINE__, ##__VA_ARGS__)
#define LogInfo(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg85,85,75;%s+%d " frmt XCODE_COLORS_RESET),__func__,__LINE__, ##__VA_ARGS__)
#define LogWarn(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg153,102,51;%s+%d " frmt XCODE_COLORS_RESET),__func__,__LINE__, ##__VA_ARGS__)
#define LogError(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;%s+%d " frmt XCODE_COLORS_RESET),__func__,__LINE__, ##__VA_ARGS__)

#endif

#else
#define LogInfo(frmt, ...)
#define LogWarn(frmt, ...)
#define LogError(frmt, ...)
#define NSLog(...)
#endif

#endif /* Header_h */
