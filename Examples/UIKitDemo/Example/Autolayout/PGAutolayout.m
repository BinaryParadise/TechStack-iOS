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

+ (NSString *)storyBoardName {
    return @"AutoLayout";
}

+ (void)equalization:(PGRouterContext *)context PGTarget("gd://UIView/Equalization") {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

+ (void)scrollView:(PGRouterContext *)context PGTarget("gd://UIView/UIScrollView") {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

@end
