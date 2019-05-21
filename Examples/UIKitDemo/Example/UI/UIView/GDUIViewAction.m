//
//  GDUIViewAction.m
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDUIViewAction.h"
#import "PGUIViewController.h"

@implementation GDUIViewAction

+ (NSString *)storyBoardName {
    return @"SBUIView";
}

+ (void)viewLifecycleAction:(PGRouterContext *)context PGTarget("gd://UIView/Lifecycle") {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

+ (void)webViewAction:(PGRouterContext *)context PGTarget("gd://UIView/WKWebView") {
    PGUIViewController *vc = [PGUIViewController new];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vc animated:YES];
}

@end
