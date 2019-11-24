//
//  TIRouterActionManager.m
//  TIRouterAction
//
//  Created by Rake Yang on 2019/8/14.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "TIRouterActionManager.h"
#import "TIRouterActionVC.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface TILogFormatter : NSObject <DDLogFormatter>

@end

@implementation TILogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    return [NSString stringWithFormat:@"%@ +%lu %@", logMessage.function, logMessage.line, logMessage.message];
}

@end

@implementation TIRouterActionManager

+ (void)load {
//    DDTTYLogger.sharedInstance.logFormatter = [TILogFormatter new];
}

+ (UIViewController *)mangerController {
    return [[TIRouterActionVC alloc] initWithNibName:nil bundle:nil];
}

@end
