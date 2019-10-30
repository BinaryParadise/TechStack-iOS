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

+ (void)equalization:(PGRouterContext *)context {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

+ (void)scrollView:(PGRouterContext *)context {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

@end
