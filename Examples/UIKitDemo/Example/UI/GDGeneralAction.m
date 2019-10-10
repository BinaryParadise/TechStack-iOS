//
//  GDGeneralAction.m
//  UIKitDemo
//
//  Created by Rake Yang on 2019/10/9.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "GDGeneralAction.h"
#import "GDSignInWithAppleViewController.h"

@implementation GDGeneralAction

+ (void)signInWithApple:(PGRouterContext *)context {
    UIViewController *vc = [[GDSignInWithAppleViewController alloc] initWithNibName:nil bundle:nil];
    [self pushViewController:vc animated:YES];
    [context finished];
}

@end