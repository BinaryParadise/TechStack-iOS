//
//  NLTIRouterActionManager.m
//  NLTIRouterAction
//
//  Created by Rake Yang on 2019/8/14.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLTIRouterActionManager.h"
#import "NLTIRouterActionVC.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface TILogFormatter : NSObject <DDLogFormatter>

@end

@implementation TILogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    return [NSString stringWithFormat:@"%@ +%lu %@", logMessage.function, logMessage.line, logMessage.message];
}

@end

@implementation NLTIRouterActionManager

+ (void)load {
//    DDTTYLogger.sharedInstance.logFormatter = [TILogFormatter new];
}

+ (UIViewController *)mangerController {
    return [[NLTIRouterActionVC alloc] initWithNibName:nil bundle:nil];
}

@end
