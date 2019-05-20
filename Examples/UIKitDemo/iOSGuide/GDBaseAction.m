//
//  GDBaseAction.m
//  iOSGuide
//
//  Created by Rake Yang on 2019/5/20.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDBaseAction.h"

@implementation GDBaseAction

+ (NSString *)storyBoardName {
    return nil;
}

+ (UIViewController *)controllerForIdentify:(NSString *)identify {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[self storyBoardName] bundle:[NSBundle mainBundle]];
    return [storyBoard instantiateViewControllerWithIdentifier:identify];
}

@end
