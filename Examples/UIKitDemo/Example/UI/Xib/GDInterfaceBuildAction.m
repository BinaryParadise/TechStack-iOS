//
//  GDInterfaceBuildAction.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/7/3.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDInterfaceBuildAction.h"

@implementation GDInterfaceBuildAction

+ (NSString *)storyBoardName {
    return @"InterfaceBuilder";
}

+ (void)xibDemo:(PGRouterContext *)context PGTarget("gd://InterfaceBuild/Storyboard") {
    [self pushViewControllerWithIdentify:@"InterfaceBuilderDemo1"];    
}

@end
