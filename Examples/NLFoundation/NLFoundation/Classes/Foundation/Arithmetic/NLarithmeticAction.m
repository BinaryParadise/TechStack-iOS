//
//  NLarithmeticAction.m
//  NLFoundation
//
//  Created by Rake Yang on 2020/9/10.
//

#import "NLarithmeticAction.h"
#import "NLArithmeticTableViewController.h"

@implementation NLarithmeticAction

+ (void)date:(PGRouterContext *)context {
    UIViewController *vc = NLArithmeticTableViewController.new;
    [self pushViewController:vc animated:YES];
}

@end
