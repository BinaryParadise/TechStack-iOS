//
//  NLLoggerModule.m
//  Neverland
//
//  Created by Rake Yang on 2019/2/19.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLLoggerModule.h"
#import <MCFrontendKit/MCFrontendKit.h>
#import <NLProtocols/NLProtocols.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface NLLoggerModule () <NLLoggerProtocol>

@end

@implementation NLLoggerModule

+ (void)initialize {
    [DDLog addLogger:DDTTYLogger.sharedInstance];
    MCFrontendKit.manager.baseURL = [NSURL URLWithString:@"http://127.0.0.1:9000"];
    MCFrontendKit.manager.enableDebug = DEBUG;
    [MCFrontendKit.manager startLogMonitor:^NSDictionary<NSString *,NSString *> *{
        return @{};
    }];
}

- (NSBundle *)resourceBundle {
    return [NSBundle mainBundle];
}

@end
