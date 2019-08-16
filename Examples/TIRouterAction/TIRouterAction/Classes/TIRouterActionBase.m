//
//  TIRouterActionBase.m
//  TIRouterAction
//
//  Created by Rake Yang on 2019/8/01.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "TIRouterActionBase.h"

@implementation TIRouterActionBase

+ (NSString *)storyBoardName {
    return nil;
}

+ (UIViewController *)controllerForIdentify:(NSString *)identify {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[self storyBoardName] bundle:[NSBundle mainBundle]];
    return [storyBoard instantiateViewControllerWithIdentifier:identify];
}

+ (void)pushViewControllerWithIdentify:(NSString *)identify {
    UIViewController *controller = [self controllerForIdentify:identify];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:controller animated:YES];
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:viewController animated:animated];
}

@end
