//
//  TIRouterActionManager.m
//  TIRouterAction
//
//  Created by Rake Yang on 2019/8/14.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLRouterActionManager.h"
#import "NLRouterActionVC.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation NLRouterActionManager

+ (UIViewController *)mangerController {
    return [[TIRouterActionVC alloc] initWithNibName:nil bundle:nil];
}

@end
