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

+ (void)buttonAction:(PGRouterContext *)context PGTarget("gd://UIControl/UIButton") {
    UIViewController *vc = [self.class controllerForIdentify:context.config.actionName];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vc animated:YES];
}

+ (void)textFieldAction:(PGRouterContext *)context PGTarget("gd://UIControl/UITextField") {
    UIViewController *vc = [self.class controllerForIdentify:context.config.actionName];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vc animated:YES];
}

@end
