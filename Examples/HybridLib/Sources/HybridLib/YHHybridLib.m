//
//  YHHybridLib.m
//  HybridLib
//
//  Created by Rake Yang on 2021/3/17.
//

#import "YHHybridLib.h"
//#import <CocoaLumberjack/CocoaLumberjack.h>
#import <WechatOpenSDK/WXApi.h>
#import <HybridLib/HybridLib-Swift.h> //动态库模式有效
//#import "HybridLib-Swift.h" //静态库模式有效

static DDLogLevel ddLogLevel = DDLogLevelVerbose;

@implementation YHHybridLib

+ (BOOL)verification {
    DDLogWarn(@"xxx");
    return [[WXApi getWXAppInstallUrl] isEqual:@"https://itunes.apple.com/cn/app/id414478124?mt=8"];
}

@end
