//
//  Header.h
//  iOSGuide
//
//  Created by odyang on 2017/10/8.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#ifndef Header_h
#define Header_h

//需要安装XcodeColors插件才能正确显示彩色日志

#if DEBUG
#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define LogInfo(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg85,85,75;%s+%d " frmt XCODE_COLORS_RESET),__func__,__LINE__, ##__VA_ARGS__)
#define LogWarn(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg153,102,51;%s+%d " frmt XCODE_COLORS_RESET),__func__,__LINE__, ##__VA_ARGS__)
#define LogError(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;%s+%d " frmt XCODE_COLORS_RESET),__func__,__LINE__, ##__VA_ARGS__)
#else
#define LogInfo(frmt, ...)
#define LogWarn(frmt, ...)
#define LogError(frmt, ...)
#define NSLog(...)
#endif

#endif /* Header_h */
