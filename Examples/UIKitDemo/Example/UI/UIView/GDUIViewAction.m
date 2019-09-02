//
//  GDUIViewAction.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDUIViewAction.h"
#import "WKWebView/GDWebViewController.h"

@implementation GDUIViewAction

+ (NSString *)storyBoardName {
    return @"SBUIView";
}

+ (void)viewLifecycleAction:(PGRouterContext *)context PGTarget("gd://UIView/Lifecycle") {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

+ (void)webViewAction:(PGRouterContext *)context PGTarget("gd://UIView/WKWebView") {
    GDWebViewController *vc = [GDWebViewController new];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vc animated:YES];
}

+ (void)labelDemo:(PGRouterContext *)context {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

@end
