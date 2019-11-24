//
//  GDAnimationAction.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/6/15.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "GDAnimationAction.h"
#import <Peregrine/Peregrine.h>
#import "GDAnimationVC.h"

@implementation GDAnimationAction

+ (NSString *)storyBoardName {
    return @"Animation";
}

+ (void)animationNormal:(PGRouterContext *)context {
    [self animationCustom:context];
}

+ (void)animationCustom:(PGRouterContext *)context {
    GDAnimationVC *vc = [self controllerForIdentify:@"Normal"];
    vc.type = [context.userInfo mc_intForKey:@"type"];
    [self pushViewController:vc animated:YES];
    [context finished];
}

+ (void)animationKeyFrame:(PGRouterContext *)context {
    [self animationNormal:context];
}

@end
