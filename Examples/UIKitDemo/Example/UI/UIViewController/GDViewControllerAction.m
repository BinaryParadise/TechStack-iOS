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

+ (void)controllAction:(PGRouterContext *)context {
    UIViewController *controller = [self controllerForIdentify:context.config.actionName];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:controller animated:YES completion:^{
        [context onDone:YES object:nil];
    }];
}

@end
