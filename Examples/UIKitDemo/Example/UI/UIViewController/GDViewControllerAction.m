//
//  GDViewControllerAction.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/5/23.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDViewControllerAction.h"

@implementation GDViewControllerAction

+ (NSString *)storyBoardName {
    return @"SBViewController";
}

+ (void)controllAction:(PGRouterContext *)context PGTarget("gd://UIViewController/PushStack") {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

@end
