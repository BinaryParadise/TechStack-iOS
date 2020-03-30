//
//  GDUIViewAction.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDUIViewAction.h"
#import "WKWebView/GDWebViewController.h"
#import "GDUICollectionViewController.h"

@implementation GDUIViewAction

+ (NSString *)storyBoardName {
    return @"SBUIView";
}

+ (void)viewLifecycleAction:(PGRouterContext *)context {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

+ (void)uiWebViewAction:(PGRouterContext *)context {
    GDWebViewController *vc = [GDWebViewController new];
    vc.useWKWebview = [context.userInfo mc_boolForKey:@"wkwebview"];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vc animated:YES];
    [context finished];
}

+ (void)wkWebViewAction:(PGRouterContext *)context {
    [self uiWebViewAction:context];
}

+ (void)labelDemo:(PGRouterContext *)context {
    [self pushViewControllerWithIdentify:context.config.actionName];
    [context finished];
}

+ (void)entrance:(PGRouterContext *)context {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[self storyBoardName] bundle:[NSBundle bundleForClass:self]];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:storyBoard.instantiateInitialViewController animated:YES completion:^{
        [context finished];
    }];
}

@end
