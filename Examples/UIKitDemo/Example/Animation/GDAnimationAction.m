//
//  GDAnimationAction.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/6/15.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDAnimationAction.h"
#import <Peregrine/Peregrine.h>

@implementation GDAnimationAction

+ (NSString *)storyBoardName {
    return @"Animation";
}
+ (void)loadingView:(PGRouterContext *)context PGTarget("ap://Animation/Loading") {
    [self pushViewControllerWithIdentify:context.config.actionName];
}

@end
