//
//  GDControlActions.m
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDControlAction.h"

@implementation GDControlAction

+ (NSString *)storyBoardName {
    return @"SBUIControl";
}

+ (void)buttonAction:(PGRouterContext *)context {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

+ (void)textFieldAction:(PGRouterContext *)context {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

@end
