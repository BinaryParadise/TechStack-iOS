//
//  GCDDemo.h
//  iOSGuide
//
//  Created by mylcode on 2017/10/7.
//  Copyright © 2017年 mylcode. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 警告：在主队列中执行同步任务会造成Dead Lock
 线程：程序执行任务的最小调度单位
 任务：其实就是代码块，需要执行的内容
 队列：用来存放任务的数组
 */
@interface GCDDemo : NSObject

/**
 异步执行+并行队列
 */
+ (void)asyncConcurrent;

/**
 异步执行+串行队列
 */
+ (void)asyncSerial;

/**
 同步执行+并行队列
 */
+ (void)syncConcurrent;

/**
 同步执行+串行队列
 */
+ (void)syncSerial;


/**
 同步执行+主队列(Dead Lock)
 */
+ (void)syncMain;

@end

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
