//
//  NLLoggerModule.m
//  Neverland
//
//  Created by Rake Yang on 2019/2/19.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLLoggerModule.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <Canary/CNManager.h>

@interface NLLoggerModule ()

@end

@implementation NLLoggerModule

+ (void)configuration {
    [DDLog addLogger:DDTTYLogger.sharedInstance];
    CNManager.manager.baseURL = [NSURL URLWithString:@"https://y.neverland.life"];
    CNManager.manager.enableDebug = DEBUG;
    [CNManager.manager startLogMonitor:^NSDictionary<NSString *,NSString *> *{
        return @{};
    }];
}

- (NSBundle *)resourceBundle {
    return [NSBundle mainBundle];
}

@end
