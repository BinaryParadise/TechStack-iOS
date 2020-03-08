//
//  NLRouterActionBase.m
//  NLRouterAction
//
//  Created by Rake Yang on 2019/8/01.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLRouterActionBase.h"

@implementation NLRouterActionBase

+ (NSString *)storyBoardName {
    return nil;
}

+ (UIViewController *)controllerForIdentify:(NSString *)identify {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[self storyBoardName] bundle:[NSBundle bundleForClass:self]];
    return [storyBoard instantiateViewControllerWithIdentifier:identify];
}

+ (void)pushViewControllerWithIdentify:(NSString *)identify {
    UIViewController *controller = [self controllerForIdentify:identify];
    [self pushViewController:controller animated:YES];
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        nav = [(UITabBarController *)rootVC selectedViewController];
    } else {
        nav = rootVC;
    }
    if (![nav isKindOfClass:[UINavigationController class]]) {
        nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        [rootVC presentViewController:nav animated:animated completion:nil];
    } else {
        [nav pushViewController:viewController animated:animated];
    }
}

@end
