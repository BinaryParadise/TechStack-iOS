//
//  PGAutolayout.m
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/15.
//  Copyright © 2019 joengzi. All rights reserved.
//

#import "PGAutoLayout.h"
#import <UIKit/UIKit.h>

@implementation PGAutoLayout

+ (void)equalization:(PGRouterContext *)context PGTarget("gd://UIView/Equalization") {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AutoLayout" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Equalization"];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vc animated:YES];
}

+ (void)scrollView:(PGRouterContext *)dict PGTarget("gd://UIView/UIScrollView") {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AutoLayout" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CSScrollView"];
    UINavigationController *nav = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vc animated:YES];
}

@end
