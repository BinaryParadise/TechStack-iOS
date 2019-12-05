//
//  NLLoggerModule.m
//  Neverland
//
//  Created by Rake Yang on 2019/2/19.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLLoggerModule.h"
#import <MCLogger/MCLogger.h>
#import <NLProtocols/NLProtocols.h>

@interface NLLogFormatter : NSObject <DDLogFormatter>

@end

@implementation NLLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    return [NSString stringWithFormat:@"%@ +%lu %@", logMessage.function, logMessage.line, logMessage.message];
}

@end

@interface NLLoggerModule () <NLLoggerProtocol>

@end

@implementation NLLoggerModule

+ (void)load {
    DDTTYLogger.sharedInstance.logFormatter = [NLLogFormatter new];
}

+ (void)initialize {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [MCLogger startMonitor:[NSURL URLWithString:@"ws://127.0.0.1:8081"]];
}

- (NSBundle *)resourceBundle {
    return [NSBundle mainBundle];
}

@end
