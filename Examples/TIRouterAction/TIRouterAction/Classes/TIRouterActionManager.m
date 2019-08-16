//
//  TIRouterActionManager.m
//  TIRouterAction
//
//  Created by Rake Yang on 2019/8/14.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "TIRouterActionManager.h"
#import "TIRouterActionViewController.h"

@implementation TIRouterActionManager

+ (UIViewController *)mangerController {
    return [[TIRouterActionViewController alloc] initWithNibName:nil bundle:nil];
}

@end
